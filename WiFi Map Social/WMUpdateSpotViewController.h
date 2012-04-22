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

@interface WMUpdateSpotViewController : UIViewController

@property (retain, nonatomic) UIBarButtonItem *updateButton;
@property (retain, nonatomic) UIBarButtonItem *cancelButton;

@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *authorLabel;
@property (retain, nonatomic) IBOutlet UIButton *likeButton;

@property (retain, nonatomic) WMSpot *spot;

- (NSDictionary *)paramsDictionary;

- (IBAction)update:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)like:(id)sender;

@end
