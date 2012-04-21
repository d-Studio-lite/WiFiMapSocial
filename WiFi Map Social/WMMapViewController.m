//
//  WMMapViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapViewController.h"
#import "WMMapView.h"

@interface WMMapViewController ()

@end

@implementation WMMapViewController

@synthesize mapView = _mapView;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (nil != self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setCenterCoordinate:[self.delegate getCurrentLocationForMapController:self]];
}

- (void)viewDidUnload
{
    self.mapView = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    self.mapView = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
