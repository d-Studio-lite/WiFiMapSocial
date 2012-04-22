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

@end

@implementation WMOfflineMapData

@synthesize region = _region;

- (id)initWithRegion:(MKCoordinateRegion)region minScale:(NSUInteger)minScale maxScale:(NSUInteger)maxScale
{
    self = [super init];
    if (nil != self)
    {
        self.region = region;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)prepareToDrawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale
{
    
}

- (void)drawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale inRect:(CGRect)rect inContext:(CGContextRef)context
{
    
}

@end