//
//  WMViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMDataController;
@class WMMapViewController;
@class WMSubmitViewController;

@interface WMMainViewController : UIViewController

@property (retain, nonatomic) WMDataController *dataController;
@property (retain, nonatomic) WMMapViewController *mapViewController;
@property (retain, nonatomic) WMSubmitViewController *submitViewController;

@property (retain, nonatomic) IBOutlet UIView *containerView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

- (IBAction)update:(id)sender;
- (IBAction)submit:(id)sender;

@end
