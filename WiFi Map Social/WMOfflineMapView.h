//
//  WMOfflineMapView.h
//  WiFi Map Social
//
//  Created by Apple on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMMapView.h"

@interface WMOfflineMapView : MKOverlayView

- (id)initWithOfflineOverlay:(id<MKOverlay>)overlay;

@end
