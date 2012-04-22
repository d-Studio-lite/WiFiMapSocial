//
//  WMSpotView.m
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotView.h"

@interface WMSpotView ()

- (WMMapViewSpotsAnnotation *)spotAnnotation;

@end

@implementation WMSpotView

- (id)initWithSpotAnnotation:(WMMapViewSpotsAnnotation *)spotAnnotation
{
    CLLocationCoordinate2D coord = [spotAnnotation coordinate];
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%f%f", coord.latitude, coord.longitude];
    self = [super initWithAnnotation:spotAnnotation reuseIdentifier:reuseIdentifier];
    if (nil != self)
    {
        [self setPinColor:MKPinAnnotationColorGreen];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (WMMapViewSpotsAnnotation *)spotAnnotation
{
    return (WMMapViewSpotsAnnotation *)self.annotation;
}

@end
