//
//  WMMapMath.h
//  WiFi Map Social
//
//  Created by Apple on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocation.h>

static const double WMMapMathDegreesPerPixel = 360.0 / 512.0;
static const double WMMapMathPixelsPerDegree = 512.0 / 360.0;

CLLocationDegrees validatedDegree(CLLocationDegrees degree)
{
    
    while (degree > 180.0)
    {
        degree -= 360.0;
    }
    while (degree < -180.0)
    {
        degree += 360.0;
    }
    return degree;
}

MKMapRect mapRectWithRegion(MKCoordinateRegion region)
{
    //MK
}

NSUInteger getScaleWith(MKCoordinateRegion mapRegion, CGRect screenRect, NSUInteger minScale, NSUInteger maxScale, NSUInteger scaleDelta)
{
    NSUInteger result = minScale;
    for (NSUInteger i = minScale;i <= maxScale; i += scaleDelta)
    {
      //  double currentDegreesPerPixel = mapRegion
    }
}

