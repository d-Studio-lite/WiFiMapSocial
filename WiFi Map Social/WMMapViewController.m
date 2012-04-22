//
//  WMMapViewController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMMapViewController.h"
#import "WMMapView.h"
#import "WMMapViewOfflineOverlay.h"
#import "WMMapViewSpotsAnnotation.h"
#import "WMSpotView.h"
#import "WMOfflineMapView.h"
#import "WMSpotData.h"
#import "WMOfflineMapData.h"
#import "WMConstants.h"

@interface WMMapViewController ()

@property (assign, nonatomic, getter = isOnline) BOOL online;
@property (retain, nonatomic) WMMapViewOfflineOverlay *offlineOverlay;

@end

@implementation WMMapViewController

@synthesize offlineOverlay = _offlineOverlay;
@synthesize mapView = _mapView;
@synthesize delegate = _delegate;
@synthesize online = _online;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (nil != self)
    {
        self.online = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];
    NSArray *lastRegionArray = [[NSUserDefaults standardUserDefaults] objectForKey:kWMUserDefaultsLastScreenPositionKey];
    if (nil != lastRegionArray)
    {
        MKCoordinateRegion region;
        region.center.latitude = [[lastRegionArray objectAtIndex:0] doubleValue];
        region.center.longitude = [[lastRegionArray objectAtIndex:1] doubleValue];
        region.span.latitudeDelta = [[lastRegionArray objectAtIndex:2] doubleValue];
        region.span.longitudeDelta = [[lastRegionArray objectAtIndex:3] doubleValue];
        [self.mapView setRegion:region];
    }
    [self addSpots:[self.delegate getSpotsAroundLocation:[self currentLocation] forMapViewController:self]];
#warning remove me!
    for (int i = 0; i < 2; ++i)
    {
        NSDictionary *networks = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"test1", @"2", @"test2", @"", @"test3", nil];
        WMSpotData *spotData = [[[WMSpotData alloc] initWithTitle:@"test" networks:networks coordinates:CLLocationCoordinate2DMake(50.45 + i /100.0 , 30.51 + i / 100.0)] autorelease];
        [self addSpots:[NSArray arrayWithObject:spotData]];
    }
}

- (void)viewDidUnload
{
    self.mapView = nil;
    self.offlineOverlay = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    self.mapView = nil;
    self.offlineOverlay = nil;
    [super dealloc];
}

- (CLLocationCoordinate2D)currentLocation
{
    return [[[self.mapView userLocation] location] coordinate];
}

- (void)setUsingOnlineMaps:(BOOL)online
{
    if (online != [self isOnline])
    {
        self.online = online;
        if (NO == online)
        {
            self.offlineOverlay = [[WMMapViewOfflineOverlay new] autorelease];
            [self.mapView addOverlay:self.offlineOverlay];
        }
        else
        {
            [self.mapView removeOverlay:self.offlineOverlay];
            self.offlineOverlay = nil;
        }
    }
}

- (void)addSpots:(NSArray *)spots
{
    for (WMSpotData *spotData in spots)
    {
        WMMapViewSpotsAnnotation *spotAnnotation = [[[WMMapViewSpotsAnnotation alloc] initWithSpotData:spotData] autorelease];
        [self.mapView addAnnotation:spotAnnotation];
    }
    [self.view setNeedsDisplay];
}

- (void)removeAllSpots
{
    NSArray *annotations = [self.mapView annotations];
    for (id <MKAnnotation> annotation in annotations)
    {
        if ([annotation isKindOfClass:[WMMapViewSpotsAnnotation class]])
        {
            [self.mapView removeAnnotation:annotation];
        }
    }
    [self.view setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark WMSpotViewDelegate methods

- (void)spotViewDidCallMenu:(WMSpotView *)spotView
{
    [self.delegate mapViewController:self didCallMenuForSpotData:spotView.spotAnnotation.spotData];
}

#pragma mark MKMapViewDelegate methods

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    MKCoordinateRegion region = [mapView region];
    NSArray *regionArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:region.center.latitude], [NSNumber numberWithDouble:region.center.longitude], [NSNumber numberWithDouble:region.span.latitudeDelta], [NSNumber numberWithDouble:region.span.longitudeDelta], nil];
    [[NSUserDefaults standardUserDefaults] setObject:regionArray forKey:kWMUserDefaultsLastScreenPositionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if (mapView != self.mapView)
    {
        return nil;
    }
    if (overlay == self.offlineOverlay)
    {
        return [[[WMOfflineMapView alloc] initWithOverlay:overlay] autorelease];
    }
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (mapView != self.mapView)
    {
        return nil;
    }
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        MKPinAnnotationView *userLocationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"userLocation"] autorelease];
        [userLocationView setEnabled:NO];
        return userLocationView;   
    }
    WMSpotView *spotView = [[[WMSpotView alloc] initWithSpotAnnotation:annotation] autorelease];
    [spotView setDraggable:NO];
    return spotView;
}

//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
//
//- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView;
//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView;
//- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error;
//
//// mapView:viewForAnnotation: provides the view for each annotation.
//// This method may be called for all or some of the added annotations.
//// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
//
//// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
//// The delegate can implement this method to animate the adding of the annotations views.
//// Use the current positions of the annotation views as the destinations of the animation.
//- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views;
//
//// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
//
//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0);
//- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0);
//
//- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView NS_AVAILABLE(NA, 4_0);
//- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView NS_AVAILABLE(NA, 4_0);
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(NA, 4_0);
//- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(NA, 4_0);
//
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState 
//fromOldState:(MKAnnotationViewDragState)oldState NS_AVAILABLE(NA, 4_0);
//
//// Called after the provided overlay views have been added and positioned in the map.
//- (void)mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews NS_AVAILABLE(NA, 4_0);
//
//- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated NS_AVAILABLE(NA, 5_0);

@end
