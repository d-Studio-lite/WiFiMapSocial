//
//  WMSubmitViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSubmitViewController.h"
#import "ASIHTTPRequest.h"
#import "XMLReader.h"

typedef enum
{
    WMResolveDuplicatesNoDuplicatesReturnCode = 0,
    WMResolveDuplicatesCloseSpotWithSamePasswordReturnCode,
    WMResolveDuplicatesCloseSpotWithDifferentPasswordReturnCode,
} WMResolveDuplicatesReturnCode;

@interface WMSubmitViewController()<ASIHTTPRequestDelegate>

@end

@implementation WMSubmitViewController

@synthesize submitButton = _submitButton;
@synthesize cancelButton = _cancelButton;

@synthesize nameTextField = _nameTextField;
@synthesize passwordTextField = _passwordTextField;

@synthesize currentLocation = _currentLocation;

-(void)dealloc
{
    self.cancelButton = nil;
    self.submitButton = nil;
    self.nameTextField = nil;
    self.passwordTextField = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.cancelButton = nil;
    self.submitButton = nil;
    self.nameTextField = nil;
    self.passwordTextField = nil;
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
    NSURL *spotsURL = [serverURL URLByAppendingPathComponent:[kWMSpotsKey stringByAppendingPathExtension:@"xml"]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:spotsURL];
    [request setDelegate:self];
    [request startAsynchronous];
    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Submitting" message:[[self paramsDictionary] description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)cancel:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
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
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSError *error = nil;
    NSDictionary *responseDictionary = [XMLReader dictionaryForXMLString:responseString error:&error];
    NSArray *spotsArray = [responseDictionary valueForKey:kWMSpotsKey];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}

@end
