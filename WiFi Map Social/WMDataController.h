//
//  WMDataController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMMapDataSource.h"

@class WMSpotSource;

@protocol WMDataContollerDelegate;

@interface WMDataController : NSObject

@property (retain, nonatomic, readonly) WMMapDataSource *mapDataSource;
@property (retain, nonatomic, readonly) WMSpotSource *spotSource;
@property (assign, nonatomic) id<WMDataContollerDelegate> delegate;

- (void)update;

- (NSArray *)spotDataArrayInRect:(CGRect)rect;
- (NSArray *)offlineMapsForLocation:(CLLocationCoordinate2D)location;

@end


@protocol WMDataContollerDelegate <NSObject>

- (CLLocationCoordinate2D)dataControllerGetCurrentLocation:(WMDataController *)dataController;
- (void)dataController:(WMDataController *)dataController updateDidFinishedWithError:(NSError *)error;

@end