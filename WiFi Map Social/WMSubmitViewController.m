//
//  WMSubmitViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSubmitViewController.h"

@interface WMSubmitViewController ()

@end

@implementation WMSubmitViewController

@synthesize submitButton = _submitButton;
@synthesize cancelButton = _cancelButton;

@synthesize nameTextField = _nameTextField;
@synthesize passwordTextField = _passwordTextField;

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

- (void)submit:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
