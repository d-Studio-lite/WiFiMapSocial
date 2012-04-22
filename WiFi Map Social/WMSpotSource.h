//
//  WMSpotSource.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMSpotSource : NSObject

- (NSArray *)spotsInRect:(CGRect)rect;
- (void)update;

@end
