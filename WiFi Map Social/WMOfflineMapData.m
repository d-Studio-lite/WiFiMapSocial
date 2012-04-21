//
//  WMOfflineMapData.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMOfflineMapData.h"

@interface WMOfflineMapData ()

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (assign, nonatomic) MKMapRect boundingMapRect;

@end

@implementation WMOfflineMapData

@synthesize coordinate = _coordinate;
@synthesize boundingMapRect = _boundingMapRect;

- (id)initWithRect:(MKMapRect)rect coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (nil != self)
    {
        self.boundingMapRect = rect;
        self.coordinate = coordinate;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (UIImage *)imageForMapRect:(MKMapRect)rect scale:(MKZoomScale)scale
{
    return nil;
}

@end
