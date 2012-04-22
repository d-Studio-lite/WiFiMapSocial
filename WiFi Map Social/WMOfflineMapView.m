//
//  WMOfflineMapView.m
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMOfflineMapView.h"

@interface WMOfflineMapView ()

- (WMMapViewOfflineOverlay *)offlineOverlay;

@end

@implementation WMOfflineMapView

- (id)initWithOfflineOverlay:(WMMapViewOfflineOverlay *)overlay
{
    self = [super initWithOverlay:overlay];
    if (nil != self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (WMMapViewOfflineOverlay *)offlineOverlay
{
    return (WMMapViewOfflineOverlay *)self.overlay;
}

- (BOOL)canDrawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale
{
    return NO;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    UIImage *mapImage = [[[self offlineOverlay] mapData] imageForMapRect:mapRect scale:zoomScale];
    CGRect drawingRect = [self rectForMapRect:mapRect];
    CGContextDrawImage(context, drawingRect, [mapImage CGImage]);
}

@end
