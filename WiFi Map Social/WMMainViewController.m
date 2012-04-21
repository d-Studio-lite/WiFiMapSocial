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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

@end
