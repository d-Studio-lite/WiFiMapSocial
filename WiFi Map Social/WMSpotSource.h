//
//  WMSpotSource.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WMSpotSourceDelegate;

@interface WMSpotSource : NSObject

@property (assign, nonatomic) id<WMSpotSourceDelegate> delegate;

- (NSArray *)spotDataArrayInRect:(CGRect)rect;
- (void)update;

@end

@protocol WMSpotSourceDelegate <NSObject>

- (void)spotSource:(WMSpotSource *)spotSource didUpdateWithError:(NSError *)error;

@end
