//
//  WMDataController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMDataController.h"
#import "WMSpotSource.h"

@interface WMDataController() <WMSpotSourceDelegate>

@property (retain, nonatomic) WMSpotSource *spotSource;
@property (retain, nonatomic) WMMapDataSource *mapDataSource;

@end

@implementation WMDataController

@synthesize spotSource = _spotSource;
@synthesize delegate = _delegate;
@synthesize mapDataSource = _mapDataSource;

- (id)init
{
    self = [super init];
    if (nil != self)
    {
        self.spotSource = [[[WMSpotSource alloc] init] autorelease];
        self.mapDataSource = [[WMMapDataSource new] autorelease];
        self.spotSource.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.spotSource = nil;
    self.mapDataSource = nil;
    self.delegate = nil;
    [super dealloc];
}

- (void)update
{
    [[self spotSource] update];
    [self performSelector:@selector(updateMapData) withObject:nil afterDelay:15.0];
}

- (void)updateMapData
{
    [[self mapDataSource] updateForLocation:[self.delegate dataControllerGetCurrentLocation:self]];
}

- (NSArray *)spotDataArrayInRect:(CGRect)rect
{
    return  [[self spotSource] spotDataArrayInRect:rect];
}

- (NSArray *)offlineMapsForLocation:(CLLocationCoordinate2D)location
{
    return [[self mapDataSource] getOfflineMapsForLocation:location];
}

- (void)spotSource:(WMSpotSource *)spotSource didUpdateWithError:(NSError *)error
{
    [self.delegate dataController:self updateDidFinishedWithError:error];
}

@end
