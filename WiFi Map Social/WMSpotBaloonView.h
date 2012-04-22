//
//  WMSpotBaloonView.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBLikeButton;
@class WMSpot;

@interface WMSpotBaloonView : UIView

@property (retain, nonatomic, readonly) UIButton *editButton;
@property (retain, nonatomic, readonly) FBLikeButton *likeButton;
@property (retain, nonatomic, readonly) WMSpot *spot;

- (id)initWithFrame:(CGRect)frame spot:(WMSpot *)spot;

@end
