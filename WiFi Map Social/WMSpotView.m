//
//  WMSpotView.m
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotView.h"

@interface WMSpotView ()

@end

@implementation WMSpotView

@synthesize delegate = _delegate;

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
        UIButton *menuButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] autorelease];
        [menuButton addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [menuButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        self.rightCalloutAccessoryView = menuButton;
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
         
- (void)menuButtonPressed
{
    [self.delegate spotViewDidCallMenu:self];
}

@end
