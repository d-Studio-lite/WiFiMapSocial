//
//  WMSpotView.h
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMMapView.h"
#import "WMMapViewSpotsAnnotation.h"

@interface WMSpotView : MKPinAnnotationView

- (id)initWithSpotAnnotation:(WMMapViewSpotsAnnotation *)spotAnnotation;

@end
