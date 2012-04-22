//
//  WMViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMMapViewController;
@class WMSubmitViewController;
@class Facebook;
@class WMUpdateSpotViewController;
@class WMAboutViewController;

#import "WMMapViewController.h"
#import "WMDataController.h"

@protocol WMFBConnectManager <NSObject>

- (NSString *)controllerAsksForCurrentUserID:(UIViewController *)controller;
- (NSString *)controllerAsksForCurrentAccessToken:(UIViewController *)controller;

@end

@interface WMMainViewController : UINavigationController <WMMapViewControllerDelegate, WMDataContollerDelegate, WMFBConnectManager>

@property (retain, nonatomic) WMDataController *dataController;
@property (retain, nonatomic) WMMapViewController *mapViewController;
@property (retain, nonatomic) WMSubmitViewController *submitViewController;
@property (retain, nonatomic) WMUpdateSpotViewController *updateSpotViewController;
@property (retain, nonatomic) WMAboutViewController *aboutViewController;

@property (nonatomic, retain) Facebook *facebook;

+ (WMMainViewController *)mainViewController;

- (IBAction)update:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)center:(id)sender;

@end
