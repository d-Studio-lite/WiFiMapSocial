//
//  WMMapViewSpotsOverlay.m
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapViewSpotsAnnotation.h"

@interface WMMapViewSpotsAnnotation ()

@property (retain, nonatomic) WMSpotData *spotData;

@end

@implementation WMMapViewSpotsAnnotation

@synthesize spotData = _spotData;

- (id)initWithSpotData:(WMSpotData *)spotData
{
    self = [super init];
    if (nil != self)
    {
        self.spotData = spotData;
    }
    return self;
}

- (void)dealloc
{
    self.spotData = nil;
    [super dealloc];
}

- (CLLocationCoordinate2D)coordinate
{
    return [self.spotData coordinates];
}

- (NSString *)title
{
    return [[self.spotData spotTitle] copy];
}

- (NSString *)subtitle
{
    return nil;
}

@end
