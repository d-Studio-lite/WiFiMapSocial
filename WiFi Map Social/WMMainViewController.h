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

@property (retain, nonatomic) IBOutlet WMDataController *dataController;
@property (retain, nonatomic) IBOutlet WMMapViewController *mapViewController;
@property (retain, nonatomic) WMSubmitViewController *submitViewController;

@end
