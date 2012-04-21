//
//  WMMapViewController.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMapView.h"

@protocol WMMapViewControllerDelegate;

@interface WMMapViewController : UIViewController <MKMapViewDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) id <WMMapViewControllerDelegate> delegate;

@end

@protocol WMMapViewControllerDelegate <NSObject>

@required

- (CLLocationCoordinate2D)getCurrentLocationForMapController:(WMMapViewController *)mapController;

@end