//
//  WMSpotSource.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotSource.h"
#import "WMAppDelegate.h"
#import "JSON.h"
#import "WMSpot.h"
#import <CoreData/CoreData.h>

@interface WMSpotSource()

- (NSManagedObjectContext *)managedObjectContext;

@end

@implementation WMSpotSource

- (id)init
{
    self = [super init];
    if (nil != self)
    {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(WMAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (NSArray *)spotsInRect:(CGRect)rect
{
    NSArray *result = nil;
    
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDSpot" inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%f < SELF.latitude) && (SELF.latitude < %f) && (%f < SELF.longtitude)  && (SELF.longtitude < %f)", rect.origin.x, rect.origin.x + rect.size.width, rect.origin.y, rect.origin.y + rect.size.height];
    [fetchRequest setPredicate:predicate];
	
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (nil != error)
    {
        NSLog(@"Error: %@", [error description]);
    }
    else
    {
        NSMutableArray *spotsArray = [NSMutableArray arrayWithCapacity:[results count]];
        for (CDSpot *coreDataSpot in results)
        {
            [spotsArray addObject:[[[WMSpot alloc] initWithCDSpot:coreDataSpot] autorelease]];
        }
        
        if ([spotsArray count] > 0)
        {
            result = [NSArray arrayWithArray:spotsArray];
        }
    }
	
	// Memory management.
	[fetchRequest release];
	
	return results;
}

- (void)fetchSpotsFromResponseString:(NSString *)response
{
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    id responseObject = [parser objectWithString:response];
    NSMutableArray *spotObjects = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *spec in responseObject)
    {
        [spotObjects addObject:[WMSpot spotWithSpec:spec]];
    }
}

@end
