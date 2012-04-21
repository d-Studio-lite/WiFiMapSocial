//
//  WMMapViewOfflineOverlay.h
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMMapView.h"

@interface WMMapViewOfflineOverlay : NSObject <MKOverlay>

//- (id)initWithMapData:

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;

@end
