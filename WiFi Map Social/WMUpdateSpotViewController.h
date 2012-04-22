//
//  WMUpdateSpotViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMSubmitViewController.h"

@class WMSpot;
@class FBLikeButton;

@protocol WMFBConnectManager;

@interface WMUpdateSpotViewController : UIViewController

@property (retain, nonatomic) UIBarButtonItem *updateButton;
@property (retain, nonatomic) UIBarButtonItem *cancelButton;

@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *authorLabel;
@property (retain, nonatomic) FBLikeButton *likeButton;

@property (retain, nonatomic) WMSpot *spot;

@property (assign, nonatomic) id<WMFBConnectManager> delegate;

- (NSDictionary *)paramsDictionary;

- (IBAction)update:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)like:(id)sender;

@end
