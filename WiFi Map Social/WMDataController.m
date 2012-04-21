//
//  WMDataController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMDataController.h"
#import "JSON.h"
#import "WMSpot.h"

@implementation WMDataController

@synthesize fetchedSpots = _fetchedSpots;

- (void)fetchSpotsFromResponseString:(NSString *)response
{
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    id responseObject = [parser objectWithString:response];
    NSMutableArray *spotObjects = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *spec in responseObject)
    {
        [spotObjects addObject:[WMSpot spotWithSpec:spec]];
    }
    self.fetchedSpots = [[spotObjects copy] autorelease];
}

@end
