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
#import "WMSpotData.h"

@interface WMMainViewController ()

@end

@implementation WMMainViewController

@synthesize dataController = _dataController;
@synthesize mapViewController = _mapViewController;
@synthesize submitViewController = _submitViewController;
@synthesize updateSpotViewController = _updateSpotViewController;

+ (WMMainViewController *)mainViewController;
{
    WMMapViewController *mapViewController = [[[WMMapViewController alloc] initWithNibName:@"WMMapView" bundle:nil] autorelease];
    
    WMMainViewController *mainViewController = [[[WMMainViewController alloc] initWithRootViewController:mapViewController] autorelease];
    mainViewController.mapViewController = mapViewController;
    [mapViewController setDelegate:mainViewController];
    
    [mainViewController setNavigationBarHidden:YES];

    [mainViewController setToolbarHidden:NO animated:NO];

    UIBarButtonItem *updateButton = [[[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:mainViewController
                                                                     action:@selector(update:)] autorelease];
    
    UIBarButtonItem *centerButton = [[[UIBarButtonItem alloc] initWithTitle:@"Center"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:mainViewController
                                                                     action:@selector(center:)] autorelease];
    
    UIBarButtonItem *submitButton = [[[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:mainViewController
                                                                     action:@selector(submit:)] autorelease];
    UIBarButtonItem *flexibleSpace1 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    UIBarButtonItem *flexibleSpace2 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:updateButton, flexibleSpace1, centerButton, flexibleSpace2, submitButton, nil];
    [mapViewController setToolbarItems:toolbarItems];

    
    return mainViewController;
}

- (void)dealloc
{
    self.mapViewController = nil;
    self.dataController = nil;
    self.submitViewController = nil;
    self.updateSpotViewController = nil;
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

- (WMUpdateSpotViewController *)updateSpotViewController
{
    if (nil == _updateSpotViewController)
    {
        [self setUpdateSpotViewController:[[[WMUpdateSpotViewController alloc] initWithNibName:@"UpdateSpotView" bundle:nil] autorelease]];
    }
    return _updateSpotViewController;
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
    CLLocationCoordinate2D currentLocation = [self.mapViewController currentLocation];
    [self.submitViewController setCurrentLocation:currentLocation];
    [self pushViewController:self.submitViewController animated:YES];
}

- (void)center:(id)sender
{
    [self.mapViewController centerMapOnCurrentLocation];
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
    NSArray *result = [[self dataController] spotDataArrayInRect:CGRectMake(45, 25, 10, 10)];
    return result;
}

//array of WMOfflineMapData
- (NSArray *)getOfflineMapDataAroundLocation:(CLLocationCoordinate2D)location forMapViewController:(WMMapViewController *)controller
{
    return [NSArray array];
}

- (void)mapViewController:(WMMapViewController *)controller didCallMenuForSpotData:(WMSpotData *)spotData
{
    [[self updateSpotViewController] setSpot:[spotData engineSpot]];
    [self pushViewController:self.updateSpotViewController animated:YES];

}

@end
