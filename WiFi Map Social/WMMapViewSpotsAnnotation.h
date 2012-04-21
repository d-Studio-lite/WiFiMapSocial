//
//  WMMapViewSpotsOverlay.h
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMMapView.h"
#import "WMSpotData.h"

@interface WMMapViewSpotsAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//optional
//@property (nonatomic, readonly, copy) NSString *title;
//@property (nonatomic, readonly, copy) NSString *subtitle;

@end
