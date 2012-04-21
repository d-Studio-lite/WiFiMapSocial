//
//  WMAppDelegate.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMMainViewController;

@interface WMAppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) WMMainViewController *mainViewController;
@property (retain, nonatomic) UINavigationController *navigationController;

@end
