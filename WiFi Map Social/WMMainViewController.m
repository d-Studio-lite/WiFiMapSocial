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
@synthesize containerView = _containerView;
@synthesize indicatorView = _indicatorView;

- (void)dealloc
{
    self.mapViewController = nil;
    self.dataController = nil;
    self.submitViewController = nil;
    self.containerView = nil;
    self.indicatorView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapViewController = [[[WMMapViewController alloc] initWithNibName:@"WMMapView" bundle:nil] autorelease];
    [self.view addSubview:[self.mapViewController view]];
    [[self.mapViewController view] setFrame:[self.containerView frame]];
}

- (void)viewDidUnload
{
    self.mapViewController = nil;
    [super viewDidUnload];
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

@end
