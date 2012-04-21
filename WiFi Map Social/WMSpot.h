//
//  WMSpot.h
//  WiFi Map Social
//
//  Created by Victoria Babakina on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface WMSpot : NSObject
{
@private
    NSDictionary *_spec;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) CGFloat lattitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, readonly) NSDictionary *spec;

- (id)initWithSpec:(NSDictionary *)newSpec;

@end
