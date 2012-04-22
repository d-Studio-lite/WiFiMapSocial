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
@property (retain, nonatomic) NSString *password;
@property (assign, nonatomic) CLLocationCoordinate2D coordinates;
@property (assign, nonatomic, getter = isHiddenNetwork) BOOL hiddenNetwork;

@end

@implementation WMSpotData

@synthesize spotTitle = _spotTitle;
@synthesize password = _password;
@synthesize coordinates = _coordinates;
@synthesize hiddenNetwork = _hiddenNetwork;


- (id)initWithEngineSpot:(WMSpot *)spot
{
    if (nil == spot)
    {
        [self release];
        return nil;
    }
    CGPoint spotCoord = [spot location];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(spotCoord.x, spotCoord.y);
    self = [self initWithTitle:[spot name] password:[spot password] coordinates:coord hiddenState:NO];
    return self;
}

- (id)initWithTitle:(NSString *)title password:(NSString *)password coordinates:(CLLocationCoordinate2D)coordinates hiddenState:(BOOL)hidden
{
    self = [super init];
    if (nil != self)
    {
        self.coordinates = coordinates;
        self.password = password;
        self.spotTitle = title;
        self.hiddenNetwork = hidden;
    }
    return self;
}

- (void)dealloc
{
    self.password = nil;
    self.spotTitle = nil;
    [super dealloc];
}

- (void)setNewPassword:(NSString *)password
{
    self.password = password;
}
- (void)setNewHiddenNetworkState:(BOOL)state
{
    self.hiddenNetwork = state;
}

@end
