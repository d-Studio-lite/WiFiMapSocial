//
//  WMAppDelegate.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMMainViewController;
@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;


@interface WMAppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) WMMainViewController *mainViewController;
@property (retain, nonatomic) UINavigationController *navigationController;

@property (retain, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (retain, nonatomic, readonly) NSPersistentStoreCoordinator *persistantStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end
