//
//  WMSpotData.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotData.h"
#import "WMSpot.h"

@interface WMSpotData ()

@property (retain, nonatomic) NSString *spotTitle;
@property (retain, nonatomic) NSDictionary *networks;
@property (assign, nonatomic) CLLocationCoordinate2D coordinates;

@end

@implementation WMSpotData

@synthesize spotTitle = _spotTitle;
@synthesize networks = _networks;
@synthesize coordinates = _coordinates;

- (id)initWithEngineSpotsArray:(NSArray *)spots
{
    if (0 == [spots count])
    {
        [self release];
        return nil;
    }
    NSMutableDictionary *networks = [NSMutableDictionary dictionaryWithCapacity:[spots count]];
    WMSpot *firstSpot = [spots objectAtIndex:0];
    CGPoint firstSpotCoord = [firstSpot location];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(firstSpotCoord.x, firstSpotCoord.y);
    NSString *name = [firstSpot name];
    for (WMSpot *spot in spots)
    {
        [networks setValue:[spot password] forKey:[spot name]];
    }
    self = [self initWithTitle:name networks:networks coordinates:coord];
    return self;
}

- (id)initWithTitle:(NSString *)title networks:(NSDictionary *)networks coordinates:(CLLocationCoordinate2D)coordinates
{
    self = [super init];
    if (nil != self)
    {
        self.coordinates = coordinates;
        self.networks = networks;
        self.spotTitle = title;
    }
    return self;
}

- (void)dealloc
{
    self.networks = nil;
    self.spotTitle = nil;
    [super dealloc];
}

@end
