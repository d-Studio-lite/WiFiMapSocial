//
//  WMSpotData.h
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WMSpot.h"

@interface WMSpotData : NSObject

- (id)initWithEngineSpot:(WMSpot *)spot;

- (void)setNewEngineSpot:(WMSpot *)spot;

@property (retain, nonatomic, readonly) WMSpot *engineSpot;
@property (retain, nonatomic, readonly) NSString *spotTitle;
@property (retain, nonatomic, readonly) NSString *password;
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinates;
@property (assign, nonatomic, readonly, getter = isHiddenNetwork) BOOL hiddenNetwork;

@end
