//
//  WMMapDataSource.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapDataSource.h"
#import "WMMapMath.h"

#define WMMapDataSourceMaxScale 19
#define WMMapDataSourceTileSize 512.0
#define WMMapDataSourceScaleDelta 2

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

- (NSArray *)getOfflineMapsForLocation:(CLLocationCoordinate2D)location
{
    CLLocationCoordinate2D center = [self getRegionCenterForLocation:location];
    MKCoordinateRegion region;
    region.center.latitude = center.latitude;
    region.center.longitude = center.longitude;
    NSUInteger minScale = [self getMinRegionScaleForLocation:location];
    region.span.latitudeDelta = (WMMapDataSourceTileSize * WMMapMathDegreesPerPixel) / (double)minScale;
    region.span.longitudeDelta = (WMMapDataSourceTileSize * WMMapMathDegreesPerPixel) / (double)minScale;
    
    WMOfflineMapData *offlineMap = [[[WMOfflineMapData alloc] initWithRegion:region minScale:minScale maxScale:WMMapDataSourceMaxScale scaleDelta:WMMapDataSourceMaxScale] autorelease];
    return [NSArray arrayWithObject:offlineMap];
}

- (void)updateForLocation:(CLLocationCoordinate2D)location
{
    NSUInteger minScale = [self getMinRegionScaleForLocation:location];
    CLLocationCoordinate2D regionCenter = [self getRegionCenterForLocation:location];
    [self getTileAndSubtilesWithCenter:regionCenter andScale:minScale andMaxScale:13];
}

- (CLLocationCoordinate2D)getRegionCenterForLocation:(CLLocationCoordinate2D)location
{
    CLLocationCoordinate2D regionCenter;
    regionCenter.latitude = 50.434154;
    regionCenter.longitude = 30.509943;
    return regionCenter;
}

- (NSUInteger)getMinRegionScaleForLocation:(CLLocationCoordinate2D)location
{
    return 9;
}

- (void)getTileAndSubtilesWithCenter:(CLLocationCoordinate2D)center andScale:(NSUInteger)scale andMaxScale:(NSUInteger)maxScale
{
    [self getImageWithCenter:center andScale:scale];
    if (scale < maxScale)
    {
        CLLocationDegrees delta = ((WMMapDataSourceTileSize * WMMapMathDegreesPerPixel) / (double)scale) / 4.0;
        CLLocationCoordinate2D leftBottom;
        leftBottom.latitude = validatedDegree(center.latitude - delta);
        leftBottom.longitude = validatedDegree(center.longitude - delta);
        CLLocationCoordinate2D leftTop;
        leftTop.latitude = validatedDegree(center.latitude - delta);
        leftTop.longitude = validatedDegree(center.longitude + delta);
        CLLocationCoordinate2D rightTop;
        rightTop.latitude = validatedDegree(center.latitude + delta);
        rightTop.longitude = validatedDegree(center.longitude + delta);
        CLLocationCoordinate2D rightBottom;
        rightBottom.latitude = validatedDegree(center.latitude + delta);
        rightBottom.longitude = validatedDegree(center.longitude - delta);
        [self getTileAndSubtilesWithCenter:leftBottom andScale:(scale + WMMapDataSourceScaleDelta) andMaxScale:maxScale];
        [self getTileAndSubtilesWithCenter:leftTop andScale:(scale + WMMapDataSourceScaleDelta) andMaxScale:maxScale];
        [self getTileAndSubtilesWithCenter:rightTop andScale:(scale + WMMapDataSourceScaleDelta) andMaxScale:maxScale];
        [self getTileAndSubtilesWithCenter:rightBottom andScale:(scale + WMMapDataSourceScaleDelta) andMaxScale:maxScale];
    }
}

- (void)getImageWithCenter:(CLLocationCoordinate2D)center andScale:(NSUInteger)scale
{
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?center=%f,%f&zoom=%u&size=512x512&sensor=true", center.latitude, center.longitude, scale]];
    __block NSMutableURLRequest *request = [[NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0] retain];
    [request setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^
    {
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (nil != data)
        {
            NSArray *docPathesArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docPath = [docPathesArray objectAtIndex:0];
            NSString *path = [NSString stringWithFormat:@"%@/%u_%f_%f.png", docPath, scale, center.latitude, center.longitude];
            [data writeToFile:path atomically:YES];
        }
        [request release];
    }];
    [self.queue addOperation:operation];
}

@end