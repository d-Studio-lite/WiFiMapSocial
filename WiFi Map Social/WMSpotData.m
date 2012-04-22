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

@property (retain, nonatomic) WMSpot *engineSpot;
@property (assign, nonatomic, getter = isHiddenNetwork) BOOL hiddenNetwork;

@end

@implementation WMSpotData

@synthesize engineSpot = _engineSpot;
@synthesize hiddenNetwork = _hiddenNetwork;

- (id)initWithEngineSpot:(WMSpot *)spot
{
    self = [super init];
    if (nil != self)
    {
        self.engineSpot = spot;
    }
    return self;
}

- (void)dealloc
{
    self.engineSpot = nil;
    [super dealloc];
}

- (void)setNewEngineSpot:(WMSpot *)spot
{
    self.engineSpot = spot;
}

- (NSString *)spotTitle
{
    return [self.engineSpot name];
}

- (NSString *)password
{
    return [self.engineSpot password];
}

- (CLLocationCoordinate2D)coordinates
{
    CGPoint spotCoord = [self.engineSpot location];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(spotCoord.x, spotCoord.y);
    return coord;
}

@end
