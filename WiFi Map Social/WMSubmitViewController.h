//
//  WMSubmitViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMSubmitViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *submitButton;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;


- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;

@end
