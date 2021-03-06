//
//  WMSubmitViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WMSubmitViewController : UIViewController

@property (retain, nonatomic) UIBarButtonItem *submitButton;
@property (retain, nonatomic) UIBarButtonItem *cancelButton;

@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel;


@property (assign, nonatomic) CLLocationCoordinate2D currentLocation;
@property (retain, nonatomic) NSString *currentUserID;

- (NSDictionary *)paramsDictionary;

- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;

@end
