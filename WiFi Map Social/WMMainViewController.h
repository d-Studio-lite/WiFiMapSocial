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
#import "WMMapViewController.h"

@interface WMMainViewController : UINavigationController <WMMapViewControllerDelegate>

@property (retain, nonatomic) WMDataController *dataController;
@property (retain, nonatomic) WMMapViewController *mapViewController;
@property (retain, nonatomic) WMSubmitViewController *submitViewController;

+ (WMMainViewController *)mainViewController;

- (IBAction)update:(id)sender;
- (IBAction)submit:(id)sender;

@end
