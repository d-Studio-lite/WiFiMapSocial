//
//  WMSubmitViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSubmitViewController.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

typedef enum
{
    WMResolveDuplicatesNoDuplicatesReturnCode = 0,
    WMResolveDuplicatesCloseSpotWithSamePasswordReturnCode,
    WMResolveDuplicatesCloseSpotWithDifferentPasswordReturnCode,
} WMResolveDuplicatesReturnCode;

@interface WMSubmitViewController()<ASIHTTPRequestDelegate, UITextFieldDelegate>

@end

@implementation WMSubmitViewController

@synthesize submitButton = _submitButton;
@synthesize cancelButton = _cancelButton;

@synthesize nameTextField = _nameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize latitudeLabel = _latitudeLabel;
@synthesize longitudeLabel = _longitudeLabel;

@synthesize currentLocation = _currentLocation;

-(void)dealloc
{
    self.cancelButton = nil;
    self.submitButton = nil;
    self.nameTextField = nil;
    self.passwordTextField = nil;
    self.latitudeLabel = nil;
    self.longitudeLabel = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    self.cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease];
    
    self.submitButton = [[[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                          style:UIBarButtonItemStyleBordered
                                                         target:self
                                                         action:@selector(submit:)] autorelease];
 
    self.nameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self validateSubmitButton];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.cancelButton = nil;
    self.submitButton = nil;
    self.nameTextField.delegate = nil;
    self.nameTextField = nil;
    self.passwordTextField.delegate = nil;
    self.passwordTextField = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.latitudeLabel setText:[[NSNumber numberWithDouble:self.currentLocation.latitude] stringValue]];
    [self.longitudeLabel setText:[[NSNumber numberWithDouble:self.currentLocation.longitude] stringValue]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (WMResolveDuplicatesReturnCode)resolveDuplicates
{
    WMResolveDuplicatesReturnCode retValue = WMResolveDuplicatesNoDuplicatesReturnCode;
     return retValue;
}

- (void)handleResolveDuplicatesReturnCode:(WMResolveDuplicatesReturnCode)returnCode
{
    switch (returnCode)
    {
        case WMResolveDuplicatesNoDuplicatesReturnCode:
        {
            break;
        }   
        case WMResolveDuplicatesCloseSpotWithSamePasswordReturnCode:
        {
            break;
        }   
        case WMResolveDuplicatesCloseSpotWithDifferentPasswordReturnCode:
        {
            break;
        }   
        default:
            break;
    }    
}

- (void)submit:(id)sender
{
    NSURL *serverURL = [NSURL URLWithString:kWMServerURL];
    NSURL *spotsURL = [serverURL URLByAppendingPathComponent:[kWMSpotsKey stringByAppendingPathExtension:@"json"]];
    
    serverURL = [NSURL URLWithString:@"http://fierce-mountain-3562.herokuapp.com/spots.json"];

    ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:spotsURL];
    [ASIFormDataRequest initialize];
    [postRequest setRequestMethod:@"POST"];
    [postRequest addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[self.nameTextField text], kWMSpotNameKey, [self.passwordTextField text], kWMSpotPasswordKey, nil];
    
    NSString *jsonParams = [params JSONRepresentation];

    [postRequest appendPostData:[jsonParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postRequest setDelegate:self];
    [postRequest startAsynchronous];
}

- (void)cancel:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)validateSubmitButton
{
    self.submitButton.enabled = [[self.nameTextField text] length] > 1 ? YES : NO;
}

- (NSArray *)toolbarItems
{
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    return [NSArray arrayWithObjects:self.cancelButton, flexibleSpace, self.submitButton, nil];
}

- (NSDictionary *)paramsDictionary
{
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                            [self.nameTextField text], kWMSpotNameKey,
                            [self.passwordTextField text], kWMSpotPasswordKey,
                            [NSNumber numberWithDouble:self.currentLocation.latitude], kWMSpotLattitudeKey,
                            [NSNumber numberWithDouble:self.currentLocation.longitude], kWMSpotLongitudeKey,
                            nil];
    return result;
}

#pragma mark ASIHTTPRequestDelegate methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self validateSubmitButton];
    return YES;
}
@end
