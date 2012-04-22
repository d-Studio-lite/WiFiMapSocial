//
//  WMDataController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WMSpotSource;

@protocol WMDataContollerDelegate;

@interface WMDataController : NSObject

@property (retain, nonatomic, readonly) WMSpotSource *spotSource;
@property (assign, nonatomic) id<WMDataContollerDelegate> delegate;

- (void)update;

@end


@protocol WMDataContollerDelegate <NSObject>

- (void)dataController:(WMDataController *)dataController updateDidFinishedWithError:(NSError *)error;

@end