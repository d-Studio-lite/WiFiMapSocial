//
//  WMSpot.m
//  WiFi Map Social
//
//  Created by Victoria Babakina on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpot.h"
#import "CDSpot.h"

@interface WMSpot()

@property (retain, nonatomic) NSMutableDictionary *spec;

@end

@implementation WMSpot

@synthesize spec = _spec;

@dynamic name, password, location, spotId, author, likeCount;


+ (WMSpot *)spotWithSpec:(NSDictionary *)spec
{
    return [[[self alloc] initWithSpec:spec] autorelease];
}

- (id)initWithSpec:(NSDictionary *)newSpec
{
    self = [self init];
    if (nil != self)
    {
        self.spec = [NSMutableDictionary dictionaryWithDictionary:newSpec];
    }
    return self;
}

- (id)initWithCDSpot:(CDSpot *)spot
{
    self = [self init];
    if (nil != self)
    {
        self.spec = [NSMutableDictionary dictionary];
        self.name = spot.name;
        self.password = spot.password;
        self.spotId = [spot.spotId integerValue];
        self.lattitude = [spot.latitude doubleValue];
        self.longitude = [spot.longtitude doubleValue];
        self.author = spot.author;
    }
    return self;
}

- (void)dealloc
{
    self.spec = nil;
    [super dealloc];
}

- (NSString *)name
{
    return [[self.spec valueForKey:kWMSpotNameKey] copy];
}

- (void)setName:(NSString *)name
{
    [self.spec setValue:[name copy] forKey:kWMSpotNameKey];
}

- (NSString *)password
{
    return [[self.spec valueForKey:kWMSpotPasswordKey] copy];
}

- (void)setPassword:(NSString *)password
{
    [self.spec setValue:[password copy] forKey:kWMSpotPasswordKey];
}

- (NSInteger)spotId
{
    return [[self.spec valueForKey:kWMSpotIdKey] integerValue];
}

- (void)setSpotId:(NSInteger)spotId
{
    [self.spec setValue:[NSNumber numberWithInteger:spotId] forKey:kWMSpotIdKey];
}

- (CGFloat)lattitude
{
    return [[self.spec valueForKey:kWMSpotLattitudeKey] doubleValue];
}

- (void)setLattitude:(CGFloat)lattitude
{
    [self.spec setValue:[NSNumber numberWithDouble:lattitude] forKey:kWMSpotLattitudeKey];
}

- (CGFloat)longitude
{
    return [[self.spec valueForKey:kWMSpotLongitudeKey] doubleValue];
}

- (void)setLongitude:(CGFloat)longitude
{
    [self.spec setValue:[NSNumber numberWithDouble:longitude] forKey:kWMSpotLongitudeKey];
}

- (CGPoint)location
{
    return CGPointMake([self lattitude], [self longitude]);
}

- (NSString *)author
{
    return [[self.spec valueForKey:kWMSpotAuthorKey] copy];
}

- (void)setAuthor:(NSString *)author
{
    [self.spec setValue:[author copy] forKey:kWMSpotAuthorKey];
}

- (NSUInteger)likeCount
{
    return [[self.spec valueForKey:kWMSpotLikeCountKey] integerValue];
}

- (void)setLikeCount:(NSUInteger)likeCount
{
    [self.spec setValue:[NSNumber numberWithUnsignedInt:likeCount] forKey:kWMSpotLikeCountKey];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%f x %f", [self lattitude], [self longitude]];
}

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithDictionary:self.spec];
}

@end
