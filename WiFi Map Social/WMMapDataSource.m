//
//  WMMapDataSource.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapDataSource.h"

#define WMMapDataSourceMaxScale 19

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
    NSUInteger minScale = [self getRegionScaleForLocation:location];
    CLLocationCoordinate2D regionCenter = [self getRegionCenterForLocation:location];
    [self getTileAndSubtilesWithCenter:regionCenter andScale:minScale andMaxScale:WMMapDataSourceMaxScale];
}

- (CLLocationCoordinate2D)getRegionCenterForLocation:(CLLocationCoordinate2D)location
{
    CLLocationCoordinate2D regionCenter;
    regionCenter.latitude = 50.434154;
    regionCenter.longitude = 30.509943;
    return regionCenter;
}

- (NSUInteger)getRegionScaleForLocation:(CLLocationCoordinate2D)location
{
    return 9;
}

- (void)getTileAndSubtilesWithCenter:(CLLocationCoordinate2D)center andScale:(NSUInteger)scale andMaxScale:(NSUInteger)maxScale
{
    [self getImageWithCenter:center andScale:scale];
    if (scale < maxScale)
    {
        CLLocationCoordinate2D leftBottom;
        CLLocationCoordinate2D leftTop;
        CLLocationCoordinate2D rightTop;
        CLLocationCoordinate2D rightBottom;
        [self getTileAndSubtilesWithCenter:leftBottom andScale:(scale + 1) andMaxScale:maxScale];
        [self getTileAndSubtilesWithCenter:leftTop andScale:(scale + 1) andMaxScale:maxScale];
        [self getTileAndSubtilesWithCenter:rightTop andScale:(scale + 1) andMaxScale:maxScale];
        [self getTileAndSubtilesWithCenter:rightBottom andScale:(scale + 1) andMaxScale:maxScale];
    }
}

- (void)getImageWithCenter:(CLLocationCoordinate2D)center andScale:(NSUInteger)scale
{
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?center=%f,%f&zoom=%u&size=512x512&sensor=true", center.latitude, center.longitude, scale]];
    NSLog(@"%@", [requestURL absoluteString]);
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