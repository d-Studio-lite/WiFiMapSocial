//
//  WMMapViewOfflineOverlay.m
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapViewOfflineOverlay.h"

@interface WMMapViewOfflineOverlay ()

@property (retain, nonatomic) WMOfflineMapData *mapData;

@end

@implementation WMMapViewOfflineOverlay

@synthesize mapData = _mapData;

- (id)initWithMapData:(WMOfflineMapData *)mapData
{
    self = [super init];
    if (nil != self)
    {
        self.mapData = nil;
    }
    return self;
}

- (void)dealloc
{
    self.mapData = nil;
    [super dealloc];
}

- (CLLocationCoordinate2D)coordinate
{
    return [self.mapData coordinate];
}

- (MKMapRect)boundingMapRect
{
    return [self.mapData boundingMapRect];
}

- (BOOL)intersectsMapRect:(MKMapRect)mapRect
{
    return MKMapRectIntersectsRect(self.boundingMapRect, mapRect);
}


@end
