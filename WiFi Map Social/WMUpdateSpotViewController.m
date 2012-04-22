//
//  WMUpdateSpotViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMUpdateSpotViewController.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "WMSpot.h"
#import "FBLikeButton.h"
#import "WMMainViewController.h"

@interface WMUpdateSpotViewController ()<ASIHTTPRequestDelegate, UITextFieldDelegate>
@property (nonatomic, retain) NSString *authorLink;
@end

@implementation WMUpdateSpotViewController

@synthesize updateButton = _updateButton;
@synthesize cancelButton = _cancelButton;
@synthesize likeButton = _likeButton;

@synthesize nameLabel = _nameLabel;
@synthesize passwordTextField = _passwordTextField;
@synthesize latitudeLabel = _latitudeLabel;
@synthesize longitudeLabel = _longitudeLabel;
@synthesize authorLabel = _authorLabel;

@synthesize spot = _spot;

@synthesize delegate = _delegate;

@synthesize authorLink = _authorLink;

-(void)dealloc
{
    self.cancelButton = nil;
    self.updateButton = nil;
    self.nameLabel = nil;
    self.passwordTextField = nil;
    self.latitudeLabel = nil;
    self.longitudeLabel = nil;
    self.authorLabel = nil;
    self.delegate = nil;
    self.authorLink = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    self.cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease];
    
    self.passwordTextField.delegate = self;
    
    self.likeButton = [[[FBLikeButton alloc] initWithFrame:CGRectMake(110, 270, 200, 200) andUrl:@"" andStyle:FBLikeButtonStyleButtonCount andColor:FBLikeButtonColorLight] autorelease];
    [self.view addSubview:self.likeButton];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.cancelButton = nil;
    self.updateButton = nil;
    self.nameLabel = nil;
    self.passwordTextField.delegate = nil;
    self.passwordTextField = nil;
    self.authorLabel = nil;
}

- (void)requestFullUserNameFromFacebookID:(NSString *)anID
{
    NSString *queryFormat = @"https://graph.facebook.com/%@";
    NSURL *searchLink = [NSURL URLWithString:[NSString stringWithFormat:queryFormat,anID]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:searchLink];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.nameLabel setText:[self.spot name]];
    [self.passwordTextField setText:[self.spot password]];
    [self.latitudeLabel setText:[[NSNumber numberWithDouble:[self.spot location].x] stringValue]];
    [self.longitudeLabel setText:[[NSNumber numberWithDouble:[self.spot location].y] stringValue]];
    [self requestFullUserNameFromFacebookID:[self.spot author]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIBarButtonItem *)updateButton
{
    if (nil == _updateButton)
    {
        [self setUpdateButton:[[[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(update:)] autorelease]];
    }
    return _updateButton;
}

- (UIBarButtonItem *)cancelButton
{
    if (nil == _cancelButton)
    {
        [self setCancelButton:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease]];
    }
    return _cancelButton;
}

- (void)update:(id)sender
{
    NSURL *serverURL = [NSURL URLWithString:kWMServerURL];
    NSString *concreteSpot = [kWMSpotsKey stringByAppendingPathComponent:[[NSNumber numberWithInteger:self.spot.spotId] stringValue]];
    NSURL *spotsURL = [serverURL URLByAppendingPathComponent:[concreteSpot stringByAppendingPathExtension:@"json"]];
    
    ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:spotsURL];
    [ASIFormDataRequest initialize];
    [postRequest setRequestMethod:@"PUT"];
    [postRequest addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    
    NSDictionary *params = [self paramsDictionary];
    
    NSString *jsonParams = [params JSONRepresentation];
    
    [postRequest appendPostData:[jsonParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postRequest setDelegate:self];
    [postRequest startAsynchronous];
}

- (void)cancel:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)like:(id)sender
{
}

- (NSArray *)toolbarItems
{
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    return [NSArray arrayWithObjects:self.cancelButton, flexibleSpace, self.updateButton, nil];
}

- (NSDictionary *)paramsDictionary
{
    WMSpot *spot = self.spot;
    [spot setPassword:[self.passwordTextField text]];
    
    return [spot dictionary];
}

#pragma mark ASIHTTPRequestDelegate methods

- (void)openAuthorLink
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.authorLink]];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([request.requestMethod isEqualToString:@"GET"])
    {
        SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
        NSString *responseString = [request responseString];
        id responseObject = [parser objectWithString:responseString];
        self.authorLabel.text = [responseObject valueForKey:@"name"];
        self.authorLink = [responseObject valueForKey:@"link"];
        self.authorLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openAuthorLink)];
        gestureRec.numberOfTouchesRequired = 1;
        gestureRec.numberOfTapsRequired = 1;
        [self.authorLabel addGestureRecognizer:gestureRec];
        [gestureRec release];
    }
    else
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

