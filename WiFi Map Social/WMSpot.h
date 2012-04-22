//
//  WMSpot.h
//  WiFi Map Social
//
//  Created by Victoria Babakina on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class CDSpot;

@interface WMSpot : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) NSInteger spotId;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, copy) NSString *author;

+ (WMSpot *)spotWithSpec:(NSDictionary *)spec;
- (id)initWithCDSpot:(CDSpot *)spot;
- (NSDictionary *)dictionary;

@end
