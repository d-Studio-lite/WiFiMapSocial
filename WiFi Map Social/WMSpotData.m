//
//  WMSpotData.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotData.h"

@interface WMSpotData ()

@property (retain, nonatomic) NSString *spotTitle;
@property (retain, nonatomic) NSDictionary *networks;
@property (assign, nonatomic) CLLocationCoordinate2D coordinates;

@end

@implementation WMSpotData

@synthesize spotTitle = _spotTitle;
@synthesize networks = _networks;
@synthesize coordinates = _coordinates;

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
