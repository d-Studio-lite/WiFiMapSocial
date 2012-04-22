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
//    CGPoint temp = [self getScaleFactorforRegion:region andRect:rect];
//    NSUInteger tileScale = temp.x;
//    NSUInteger tilesCount = temp.y;
//    
//    void *buffer = malloc(4 * (NSUInteger)rect.size.width * (NSUInteger)rect.size.height);
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    CGContextRef tempContext = CGBitmapContextCreate(buffer, rect.size.width, rect.size.height, 8, 4 * rect.size.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
//    
//    NSUInteger tilesCount = (1 - pow(4, ((self.maxScale - self.minScale) / 2) + 1)) / (1 - 4);
//    for (int i = 0; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
//    
//    
//    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, rect.size.height);
//    CGContextConcatCTM(tempContext, flipVertical);
//    CGImageRef cgImage = CGBitmapContextCreateImage(tempContext);
//    CGContextDrawImage(context, rect, cgImage);
//    CGImageRelease(cgImage);
//    free(buffer);
//    CGColorSpaceRelease(colorSpaceRef);
}

- (CGPoint)getScaleFactorforRegion:(MKCoordinateRegion)region andRect:(CGRect)rect
{
    double currentDegreesPerPixel = MAX(region.span.latitudeDelta / rect.size.width, region.span.latitudeDelta / rect.size.height);
    NSUInteger currentScale = self.minScale;
    NSUInteger elementsCount = 0;
    NSUInteger iterator = 1;
    for (NSUInteger i = self.minScale + 1; i <= self.maxScale; i += self.scaleDelta)
    {
        if (currentDegreesPerPixel >  (512.0 * (360.0 / 512.0)) / (double)i)
        {
            break;
        }
        currentScale = self.minScale;
        elementsCount += iterator;
        iterator = iterator * 4;
    }
    return CGPointMake(currentScale, elementsCount);
}

@end