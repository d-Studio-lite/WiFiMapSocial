//
//  WMMapDataSource.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapDataSource.h"

#define WMMapViewDataSourceTileWidth 320.0
#define WMMapViewDataSourceTileHeight 416.0

@interface WMMapDataSource ()

@property (retain, nonatomic) NSOperationQueue *queue;

@end

@implementation WMMapDataSource

@synthesize queue = _queue;

- (id)init
{
    self = [super init];
    if (nil != self)
    {
        self.queue = [[NSOperationQueue new] autorelease];
        [self.queue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)dealloc
{
    self.queue = nil;
    [super dealloc];
}


- (void)updateForLocation:(CLLocationCoordinate2D)location
{
    for (NSUInteger scale = 0; scale < 22; ++scale)
    {
        MKCoordinateRegion region = [self getRegionForLocation:location];
        [self getImageWithCenter:region.center andScale:scale];
    }
}

- (MKCoordinateRegion)getRegionForLocation:(CLLocationCoordinate2D)location
{
    MKCoordinateRegion region;
    region.center.latitude = 50.434154;
    region.center.longitude = 30.509943;
    region.span.latitudeDelta = 0.369987;
    region.span.longitudeDelta = 0.446815;
    return region;
}

- (void)getImageWithCenter:(CLLocationCoordinate2D)center andScale:(NSUInteger)scale
{
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?center=%f,%f&zoom=%u&size=%ux%u&sensor=true", center.latitude, center.longitude, scale, WMMapViewDataSourceTileWidth, WMMapViewDataSourceTileWidth]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
    [request setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if (nil != data)
        {
            NSArray *docPathesArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docPath = [docPathesArray objectAtIndex:0];
            NSString *path = [NSString stringWithFormat:@"%@/%u_%f_%f.png", docPath, scale, center.latitude, center.longitude];
            [data writeToFile:path atomically:YES];
        }
    }];
}

@end