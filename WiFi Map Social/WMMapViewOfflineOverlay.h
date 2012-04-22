//
//  WMMapViewOfflineOverlay.h
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMMapView.h"
#import "WMOfflineMapData.h"

@interface WMMapViewOfflineOverlay : NSObject <MKOverlay>

- (id)initWithMapData:(WMOfflineMapData *)mapData;

@property (retain, nonatomic, readonly) WMOfflineMapData *mapData;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;

@end
