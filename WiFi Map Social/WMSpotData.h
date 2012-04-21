//
//  WMSpotData.h
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WMSpotData : NSObject

- (id)initWithTitle:(NSString *)title networks:(NSDictionary *)networks coordinates:(CLLocationCoordinate2D)coordinates;

@property (retain, nonatomic, readonly) NSString *spotTitle;
@property (retain, nonatomic, readonly) NSDictionary *networks; //key - @"networkName", value - @"password" (or @"" for free network)
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinates;

@end
