//
//  WMSpot.m
//  WiFi Map Social
//
//  Created by Victoria Babakina on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpot.h"
#import "CDSpot.h"

@implementation WMSpot
@dynamic name, password, location;

+ (WMSpot *)spotWithSpec:(NSDictionary *)spec
{
    return [[[self alloc] initWithSpec:spec] autorelease];
}

- (id)initWithSpec:(NSDictionary *)newSpec
{
    self = [self init];
    if (nil != self)
    {
        _spec = [NSMutableDictionary dictionaryWithDictionary:newSpec];
    }
    return self;
}

- (id)initWithCDSpot:(CDSpot *)spot
{
    self = [self init];
    if (nil != self)
    {
        _spec = [NSMutableDictionary dictionary];
        self.name = spot.name;
        self.password = spot.password;
        self.lattitude = [spot.latitude doubleValue];
        self.longitude = [spot.longtitude doubleValue];
    }
    return self;
}

- (void)dealloc
{
    [_spec release];
    _spec = nil;
    [super dealloc];
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
    return [[_spec valueForKey:kWMSpotLattitudeKey] doubleValue];
}

- (void)setLattitude:(CGFloat)lattitude
{
    [_spec setValue:[NSNumber numberWithDouble:lattitude] forKey:kWMSpotLattitudeKey];
}

- (CGFloat)longitude
{
    return [[_spec valueForKey:kWMSpotLongitudeKey] doubleValue];
}

- (void)setLongitude:(CGFloat)longitude
{
    [_spec setValue:[NSNumber numberWithDouble:longitude] forKey:kWMSpotLongitudeKey];
}

- (NSDictionary *)spec
{
    return [_spec copy];
}

- (CGPoint)location
{
    return CGPointMake([self lattitude], [self longitude]);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%f x %f", [self lattitude], [self longitude]];
}

@end
