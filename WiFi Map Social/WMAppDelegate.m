//
//  WMAppDelegate.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMAppDelegate.h"

#import "WMMainViewController.h"
#import <CoreData/CoreData.h>

@interface WMAppDelegate()

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (retain, nonatomic) NSPersistentStoreCoordinator *persistantStoreCoordinator;

@end

@implementation WMAppDelegate

@synthesize window = _window;
@synthesize mainViewController = _mainViewController;
@synthesize navigationController = _navigationController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistantStoreCoordinator = _persistantStoreCoordinator;

- (void)dealloc
{
    self.window = nil;
    self.mainViewController = nil;
    self.navigationController = nil;
    
    self.managedObjectContext = nil;
    self.persistantStoreCoordinator = nil;
    self.managedObjectModel = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    
    self.mainViewController = [WMMainViewController mainViewController];
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (nil == _managedObjectContext)
    {
        [self setManagedObjectContext:[[NSManagedObjectContext alloc] init]];
        [self.managedObjectContext setPersistentStoreCoordinator:[self persistantStoreCoordinator]];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (nil == _managedObjectModel)
    {
        [self setManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistantStoreCoordinator
{
    if (nil == _persistantStoreCoordinator)
    {
        [self setPersistantStoreCoordinator:[[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]] autorelease]];
    }
    return _persistantStoreCoordinator;
}

@end
