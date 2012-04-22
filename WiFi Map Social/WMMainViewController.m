//
//  WMViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMainViewController.h"
#import "WMDataController.h"
#import "WMMapViewController.h"
#import "WMSubmitViewController.h"
#import "WMUpdateSpotViewController.h"
#import "WMAboutViewController.h"
#import "WMSpotData.h"

#import "FBConnect.h"
#import "ASIHTTPRequest.h"

@interface WMMainViewController()<FBSessionDelegate>

@property (retain, nonatomic) NSString *currentUserID;

@end

@implementation WMMainViewController

@synthesize dataController = _dataController;
@synthesize mapViewController = _mapViewController;
@synthesize submitViewController = _submitViewController;
@synthesize updateSpotViewController = _updateSpotViewController;
@synthesize aboutViewController = _aboutViewController;

@synthesize facebook;
@synthesize currentUserID = _currentUserID;

#define isNotFirstLaunchKey @"isNotFirstLaunch"

+ (WMMainViewController *)mainViewController;
{
    WMMapViewController *mapViewController = [[[WMMapViewController alloc] initWithNibName:@"WMMapView" bundle:nil] autorelease];
    
    WMMainViewController *mainViewController = [[[WMMainViewController alloc] initWithRootViewController:mapViewController] autorelease];
    mainViewController.mapViewController = mapViewController;
    [mapViewController setDelegate:mainViewController];
    
    [mainViewController setupFacebook];
    
    [mainViewController setupToolbar];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:isNotFirstLaunchKey])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isNotFirstLaunchKey];
        [mainViewController pushViewController:mainViewController.aboutViewController animated:YES];
    }
    return mainViewController;
}

- (void)dealloc
{
    self.mapViewController = nil;
    self.dataController = nil;
    self.submitViewController = nil;
    facebook = nil;
    self.currentUserID;
    [super dealloc];
}

- (void)setupToolbar
{
    [self setNavigationBarHidden:YES];
    
    [self setToolbarHidden:NO animated:NO];
    
    UIBarButtonItem *updateButton = [[[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(update:)] autorelease];
    
    UIBarButtonItem *submitButton = [[[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(submit:)] autorelease];
    NSString *title = nil;
    SEL action = NULL;
    if (![facebook isSessionValid])
    {
        title = @"Log in";
        action = @selector(login:);
    }
    else
    {
        title = @"Log out";
        action = @selector(logout:);
    }
    
    UIBarButtonItem *facebookButton = [[[UIBarButtonItem alloc] initWithTitle:title
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:action] autorelease];
    
    
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:updateButton, flexibleSpace, facebookButton, flexibleSpace, submitButton, nil];
    [self.mapViewController setToolbarItems:toolbarItems];
}

- (void)login:(id)sender
{
    [facebook authorize:nil];
}

- (void)logout:(id)sender
{
    [facebook logout];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (WMSubmitViewController *)submitViewController
{
    if (nil == _submitViewController)
    {
        [self setSubmitViewController:[[[WMSubmitViewController alloc] initWithNibName:@"SubmitView" bundle:nil] autorelease]];
    }
    return _submitViewController;
}

- (WMUpdateSpotViewController *)updateSpotViewController
{
    if (nil == _updateSpotViewController)
    {
        [self setUpdateSpotViewController:[[[WMUpdateSpotViewController alloc] initWithNibName:@"UpdateSpotView" bundle:nil] autorelease]];
    }
    return _updateSpotViewController;
}

- (WMAboutViewController *)aboutViewController
{
    if (nil == _aboutViewController)
    {
        [self setAboutViewController:[[[WMAboutViewController alloc] initWithNibName:@"AboutView" bundle:nil] autorelease]];
    }
    return _aboutViewController;
}

- (NSString *)currentUserID
{
    NSString *validURL = [k_ME_URL stringByAppendingFormat:@"?access_token=%@",facebook.accessToken];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:validURL]];
    [request startSynchronous];
    NSString *responseString = [request responseString];
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    id responseObject = [parser objectWithString:responseString];
    return [responseObject valueForKey:@"id"];   
}

- (WMDataController *)dataController
{
    if (nil == _dataController)
    {
        [self setDataController:[[[WMDataController alloc] init] autorelease]];
        _dataController.delegate = self;
    }
    return _dataController;
}

- (void)update:(id)sender
{
    [[self dataController] update];
}

- (void)submit:(id)sender
{
    if (![facebook isSessionValid])
    {
        [self login:self];
    }
    CLLocationCoordinate2D currentLocation = [self.mapViewController currentLocation];
    [self.submitViewController setCurrentLocation:currentLocation];
    [self.submitViewController setCurrentUserID:[self.currentUserID copy]];
    [self pushViewController:self.submitViewController animated:YES];
}

- (void)center:(id)sender
{
    [self.mapViewController centerMapOnCurrentLocation];
}

- (CLLocationCoordinate2D)dataControllerGetCurrentLocation:(WMDataController *)dataController
{
    return [self.mapViewController currentLocation];
}

- (void)dataController:(WMDataController *)dataController updateDidFinishedWithError:(NSError *)error
{
    if (nil != error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Error" message:[NSError description] delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self.mapViewController removeAllSpots];
        [self.mapViewController addSpots:[[self dataController] spotDataArrayInRect:CGRectMake(45, 25, 10, 10)]];
    }
}

#pragma mark WMMapViewControllerDelegate methods
#warning implement me

//array of WMSpotData
- (NSArray *)getSpotsAroundLocation:(CLLocationCoordinate2D)location forMapViewController:(WMMapViewController *)controller
{
    NSArray *result = [[self dataController] spotDataArrayInRect:CGRectMake(48.5, 28.5, 3.0, 3.0)];
    return result;
}

//array of WMOfflineMapData
- (NSArray *)getOfflineMapDataAroundLocation:(CLLocationCoordinate2D)location forMapViewController:(WMMapViewController *)controller
{
    return [NSArray array];
}

#pragma mark FACEBOOK

- (void)setupFacebook
{
    facebook = [[Facebook alloc] initWithAppId:k_APP_ID andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"])
    {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
}

#pragma mark FBSessionDelegate methods

- (void)fbDidLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [self setupToolbar];
}

- (void)fbDidLogout
{
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    [self setupToolbar];
    
    self.currentUserID = nil;
}
    
- (void)mapViewController:(WMMapViewController *)controller didCallMenuForSpotData:(WMSpotData *)spotData
{
    [[self updateSpotViewController] setSpot:[spotData engineSpot]];
    self.updateSpotViewController.delegate = self;
    [self pushViewController:self.updateSpotViewController animated:YES];

}

#pragma mark WMFBConnectManager methods

- (NSString *)controllerAsksForCurrentUserID:(UIViewController *)controller
{
    return [self.currentUserID copy];
}

- (NSString *)controllerAsksForCurrentAccessToken:(UIViewController *)controller
{
    return [[self.facebook accessToken] copy];
}

@end
