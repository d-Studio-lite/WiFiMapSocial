//
//  WMOfflineMapData.h
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WMOfflineMapData : NSObject

- (id)initWithRect:(MKMapRect)rect coordinate:(CLLocationCoordinate2D)coordinate;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;

- (UIImage *)imageForMapRect:(MKMapRect)rect scale:(MKZoomScale)scale;

@end
