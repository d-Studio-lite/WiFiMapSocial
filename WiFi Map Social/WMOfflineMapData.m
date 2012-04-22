//
//  WMOfflineMapData.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMOfflineMapData.h"

@interface WMOfflineMapData ()

@property (assign, nonatomic) MKCoordinateRegion region;
@property (assign, nonatomic) NSUInteger minScale;
@property (assign, nonatomic) NSUInteger maxScale;
@property (assign, nonatomic) NSUInteger scaleDelta;

@end

@implementation WMOfflineMapData

@synthesize region = _region;
@synthesize minScale = _minScale;
@synthesize maxScale = _maxScale;
@synthesize scaleDelta = _scaleDelta;

- (id)initWithRegion:(MKCoordinateRegion)region minScale:(NSUInteger)minScale maxScale:(NSUInteger)maxScale scaleDelta:(NSUInteger)delta
{
    self = [super init];
    if (nil != self)
    {
        self.region = region;
        self.maxScale = maxScale;
        self.minScale = minScale;
        self.scaleDelta = delta;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (CLLocationCoordinate2D)coordinate
{
    return self.region.center;
}

- (void)prepareToDrawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale
{
    
}

- (void)drawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale inRect:(CGRect)rect inContext:(CGContextRef)context
{
    
}

@end