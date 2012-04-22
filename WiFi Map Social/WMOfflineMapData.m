//
//  WMOfflineMapData.m
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMOfflineMapData.h"

@interface WMOfflineMapData ()

@property (assign, nonatomic) MKCoordinateRegion region;
@property (assign, nonatomic) NSUInteger minScale;
@property (assign, nonatomic) NSUInteger maxScale;
@property (assign, nonatomic) NSUInteger scaleDelta;

@end

@implementation WMOfflineMapData

@synthesize region = _region;
@synthesize minScale = _minScale;
@synthesize maxScale = _maxScale;
@synthesize scaleDelta = _scaleDelta;

- (id)initWithRegion:(MKCoordinateRegion)region minScale:(NSUInteger)minScale maxScale:(NSUInteger)maxScale scaleDelta:(NSUInteger)delta
{
    self = [super init];
    if (nil != self)
    {
        self.region = region;
        self.maxScale = maxScale;
        self.minScale = minScale;
        self.scaleDelta = delta;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (CLLocationCoordinate2D)coordinate
{
    return self.region.center;
}

- (void)prepareToDrawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale
{
    
}

- (void)drawImageForRegion:(MKCoordinateRegion)region scale:(MKZoomScale)scale inRect:(CGRect)rect inContext:(CGContextRef)context
{
    CGPoint temp = [self getScaleFactorforRegion:region andRect:rect];
    NSUInteger tileScale = temp.x;
    NSUInteger tilesCountSqrt = sqrt(temp.y);
    double currentDrawingPixelPerDegrees = MAX(1 / (region.span.latitudeDelta / rect.size.width), 1/ (region.span.latitudeDelta / rect.size.height));
    
    void *buffer = malloc(4 * rect.size.width * rect.size.height);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef tempContext = CGBitmapContextCreate(buffer, rect.size.width, rect.size.height, 8, 4 * rect.size.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    
    MKCoordinateRegion currentRegion = self.region;
    
    MKCoordinateRegion tileRegion;
    tileRegion.span.latitudeDelta = ((360.0 / 512.0) / (double)tileScale) / (double)tilesCountSqrt;
    tileRegion.span.longitudeDelta = ((360.0 / 512.0) / (double)tileScale) / (double)tilesCountSqrt;
    tileRegion.center.latitude = currentRegion.center.latitude - (currentRegion.span.latitudeDelta / 2) + tileRegion.span.latitudeDelta;
    tileRegion.center.longitude = currentRegion.center.longitude - (currentRegion.span.longitudeDelta / 2) + tileRegion.span.longitudeDelta;
    for (int i = 0; i < tilesCountSqrt; ++i)
    {
        for (int j = 0; j < tilesCountSqrt; ++j)
        {
            if (tileRegion.center.latitude + (tileRegion.span.latitudeDelta / 2.0) < region.center.latitude - (tileRegion.span.latitudeDelta / 2.0))
            {
                break;
            }
            if (tileRegion.center.longitude + (tileRegion.span.longitudeDelta / 2.0) < region.center.longitude - (tileRegion.span.longitudeDelta / 2.0))
            {
                continue;
            }
            NSArray *docPathesArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docPath = [docPathesArray objectAtIndex:0];
            NSString *path = [NSString stringWithFormat:@"%@/%u_%f_%f.png", docPath, tileScale, tileRegion.center.latitude, tileRegion.center.longitude];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (nil != image)
            {
                MKCoordinateRegion intersexts = [self intersectionOfRegions:tileRegion second:region];
                CGRect drawingRect = CGRectMake((fabsf(region.center.latitude - tileRegion.center.latitude) / region.span.latitudeDelta) * rect.size.width, (fabsf(region.center.longitude - tileRegion.center.longitude) / region.span.longitudeDelta) * rect.size.height ,intersexts.span.latitudeDelta * currentDrawingPixelPerDegrees, intersexts.span.longitudeDelta * currentDrawingPixelPerDegrees);
                CGContextDrawImage(tempContext, drawingRect, image.CGImage);
            }
        }
        tileRegion.center.latitude += tileRegion.span.latitudeDelta;
        tileRegion.center.longitude = currentRegion.center.longitude - (currentRegion.span.longitudeDelta / 2) + tileRegion.span.longitudeDelta;
    }
    
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, rect.size.height);
    CGContextConcatCTM(tempContext, flipVertical);
    CGImageRef cgImage = CGBitmapContextCreateImage(tempContext);
    CGContextDrawImage(context, rect, cgImage);
    CGImageRelease(cgImage);
    free(buffer);
    CGColorSpaceRelease(colorSpaceRef);
}

- (MKCoordinateRegion)intersectionOfRegions:(MKCoordinateRegion)first second:(MKCoordinateRegion)second
{
    MKCoordinateRegion intersection;
    intersection.center.latitude = MAX(first.center.latitude, second.center.latitude);
    intersection.center.longitude = MAX(first.center.longitude, second.center.longitude);
    intersection.span.latitudeDelta = MIN(first.center.latitude + first.span.latitudeDelta, second.center.latitude + second.span.latitudeDelta) - fabs(first.center.latitude - second.center.latitude);
    intersection.span.longitudeDelta = MIN(first.center.longitude + first.span.longitudeDelta, second.center.longitude + second.span.longitudeDelta) - fabs(first.center.longitude - second.center.longitude);
    return intersection;
}

- (CGPoint)getScaleFactorforRegion:(MKCoordinateRegion)region andRect:(CGRect)rect
{
    double currentDegreesPerPixel = MAX(region.span.latitudeDelta / rect.size.width, region.span.latitudeDelta / rect.size.height);
    NSUInteger currentScale = self.minScale;
    NSUInteger elementsCount = 1;
    NSUInteger iterator = 1;
    for (NSUInteger i = self.minScale + 1; i <= self.maxScale; i += self.scaleDelta)
    {
        if (currentDegreesPerPixel >  (512.0 * (360.0 / 512.0)) / (double)i)
        {
            break;
        }
        currentScale = self.minScale;
        elementsCount = iterator * 4;
        iterator = iterator * 4;
    }
    return CGPointMake(currentScale, elementsCount);
}

@end