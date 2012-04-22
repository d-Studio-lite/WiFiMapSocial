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

- (id)initWithRegion:(MKCoordinateRegion)region minScale:(NSUInteger)minScale maxScale:(NSUInteger)maxScale scaleDelta:(NSUInteger)delta;

@property (assign, nonatomic, readonly) MKCoordinateRegion region;

- (void)prepareToDrawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale;
- (void)drawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale inRect:(CGRect)rect inContext:(CGContextRef)context;

@end
