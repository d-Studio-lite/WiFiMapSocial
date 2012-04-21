//
//  WMSpot.m
//  WiFi Map Social
//
//  Created by Victoria Babakina on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpot.h"

@implementation WMSpot
@synthesize name = _name, password = _password, lattitude = _lattitude, longitude = _longitude;

- (id)initWithSpec:(NSDictionary *)newSpec
{
    self = [self init];
    if (nil != self)
    {
        _spec = [newSpec copy];
    }
    return self;
}

- (NSString *)name
{
    return [[_spec valueForKey:kWMSpotNameKey] copy];
}

- (void)setName:(NSString *)name
{
    [_spec setValue:[name copy] forKey:kWMSpotNameKey];
}

- (NSString *)password
{
    return [[_spec valueForKey:kWMSpotPasswordKey] copy];
}

- (void)setPassword:(NSString *)password
{
    [_spec setValue:[password copy] forKey:kWMSpotPasswordKey];
}

- (CGFloat)lattitude
{
    return [[_spec valueForKey:kWMSpotLattitudeKey] floatValue];
}

- (void)setLattitude:(CGFloat)lattitude
{
    [_spec setValue:[NSNumber numberWithFloat:lattitude] forKey:kWMSpotLattitudeKey];
}

- (CGFloat)longitude
{
    return [[_spec valueForKey:kWMSpotLongitudeKey] floatValue];
}

- (void)setLongitude:(CGFloat)longitude
{
    [_spec setValue:[NSNumber numberWithFloat:longitude] forKey:kWMSpotLongitudeKey];
}

- (NSDictionary *)spec
{
    return [_spec copy];
}

@end
