//
//  WMAboutViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMAboutViewController.h"

@interface WMAboutViewController ()

@end

@implementation WMAboutViewController

@synthesize okButton = _okButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (nil != self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.okButton = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    self.okButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(ok:)] autorelease];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.okButton = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSArray *)toolbarItems
{
    UIBarButtonItem *flexibleSpace1 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    UIBarButtonItem *flexibleSpace2 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    return [NSArray arrayWithObjects:flexibleSpace1, self.okButton, flexibleSpace2, nil];
}

- (void)ok:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
