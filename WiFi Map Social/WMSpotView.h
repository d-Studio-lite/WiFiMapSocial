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

@protocol WMSpotViewDelegate;

@interface WMSpotView : MKPinAnnotationView

@property (assign, nonatomic) id <WMSpotViewDelegate> delegate;

- (WMMapViewSpotsAnnotation *)spotAnnotation;
- (id)initWithSpotAnnotation:(WMMapViewSpotsAnnotation *)spotAnnotation;

@end

@protocol WMSpotViewDelegate <NSObject>

@required

- (void)spotViewDidCallMenu:(WMSpotView *)spotView;

@end
