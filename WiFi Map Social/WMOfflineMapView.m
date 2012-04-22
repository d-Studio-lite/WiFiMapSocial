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
    return YES;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    CGRect rect = [self rectForMapRect:mapRect];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    [[self.offlineOverlay mapData] drawImageForRegion:region scale:zoomScale inRect:rect inContext:context];
}

@end
