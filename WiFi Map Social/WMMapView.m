//
//  WMMapView.m
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapView.h"

@interface WMMapView ()

@end

@implementation WMMapView

@synthesize mapView = _mapView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (nil != self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    self.mapView = nil;
    [super dealloc];
}

@end
