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
        [self setEnabled:YES];
        [self setCanShowCallout:YES];
        [self setPinColor:MKPinAnnotationColorGreen];
        self.leftCalloutAccessoryView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)] autorelease];
        [self.leftCalloutAccessoryView setBackgroundColor:[UIColor redColor]];
        self.rightCalloutAccessoryView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)] autorelease];
        [self.rightCalloutAccessoryView setBackgroundColor:[UIColor greenColor]];
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
