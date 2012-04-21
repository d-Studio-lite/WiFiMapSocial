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

@interface WMMainViewController ()

@end

@implementation WMMainViewController

@synthesize dataController = _dataController;
@synthesize mapViewController = _mapViewController;
@synthesize submitViewController = _submitViewController;

+ (WMMainViewController *)mainViewController;
{
    WMMapViewController *mapViewController = [[[WMMapViewController alloc] initWithNibName:@"WMMapView" bundle:nil] autorelease];
    WMMainViewController *mainViewController = [[[WMMainViewController alloc] initWithRootViewController:mapViewController] autorelease];
    mainViewController.mapViewController = mapViewController;
    [mainViewController setNavigationBarHidden:YES];

    UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(update:)];
    
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(update:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:updateButton, flexibleSpace, submitButton, nil];
    [mainViewController.toolbar setItems:toolbarItems animated:NO];
    return mainViewController;
}

- (void)dealloc
{
    self.mapViewController = nil;
    self.dataController = nil;
    self.submitViewController = nil;
    [super dealloc];
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

- (WMDataController *)dataController
{
    if (nil != _dataController)
    {
        [self setDataController:[[[WMDataController alloc] init] autorelease]];
    }
    return _dataController;
}

- (void)update:(id)sender
{
    
}

- (void)submit:(id)sender
{
    [[self navigationController] pushViewController:self.submitViewController animated:YES];
}

#pragma mark WMMapViewControllerDelegate methods
#warning implement me

- (CLLocationCoordinate2D)getCurrentLocationForMapController:(WMMapViewController *)mapController
{
    CLLocationCoordinate2D result;
    result.latitude = 0.0;
    result.longitude = 0.0;
    return result;
}

@end
