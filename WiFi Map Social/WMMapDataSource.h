//
//  WMMapDataSource.h
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WMOfflineMapData.h"

@interface WMMapDataSource : NSObject

- (void)updateForLocation:(CLLocationCoordinate2D)location;

- (NSArray *)getOfflineMapsForLocation:(CLLocationCoordinate2D)location;

@end
