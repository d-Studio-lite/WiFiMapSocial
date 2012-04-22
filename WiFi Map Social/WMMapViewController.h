//
//  WMMapViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMapView.h"
#import "WMSpotView.h"

@protocol WMMapViewControllerDelegate;

@class Reachability;

@interface WMMapViewController : UIViewController <MKMapViewDelegate, WMSpotViewDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) id <WMMapViewControllerDelegate> delegate;
@property (retain, nonatomic) Reachability *internetReachability;

- (void)setUsingOnlineMaps:(BOOL)online;
- (CLLocationCoordinate2D)currentLocation;

- (void)centerMapOnCurrentLocation;
- (void)addSpots:(NSArray *)spots;
- (void)removeSpotWithSpotData:(WMSpotData *)spotData;
- (void)removeAllSpots;

-(void)checkNetworkStatus:(NSNotification *)notice;

@end

@protocol WMMapViewControllerDelegate <NSObject>

@required

- (void)mapViewController:(WMMapViewController *)controller didCallMenuForSpotData:(WMSpotData *)spotData;
- (NSArray *)getSpotsAroundLocation:(CLLocationCoordinate2D)location forMapViewController:(WMMapViewController *)controller;
- (NSArray *)getOfflineMapDataAroundLocation:(CLLocationCoordinate2D)location forMapViewController:(WMMapViewController *)controller;

@end

