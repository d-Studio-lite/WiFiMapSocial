//
//  WMSpotSource.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotSource.h"
#import "WMSpotData.h"
#import "WMAppDelegate.h"
#import "JSON.h"
#import "WMSpot.h"
#import "ASIHTTPRequest.h"
#import <CoreData/CoreData.h>
#import "CDSpot.h"

#define kWMUpdaetRequestString @"updateRequest"
#define kWMRequestTypeKey @"requestType"

@interface WMSpotSource()<ASIHTTPRequestDelegate>

- (NSManagedObjectContext *)managedObjectContext;
- (void)resetCoreData:(NSArray *)spots;
- (NSArray *)fetchSpotsFromResponseString:(NSString *)response;

@end

@implementation WMSpotSource

@synthesize delegate = _delegate;

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
    self.delegate = nil;
    [super dealloc];
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(WMAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (NSArray *)spotDataArrayInRect:(CGRect)rect
{
    NSArray *result = nil;
    
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
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
        NSMutableArray *spotDatas = [NSMutableArray arrayWithCapacity:[results count]];
        for (CDSpot *coreDataSpot in results)
        {
            WMSpot *spot = [[[WMSpot alloc] initWithCDSpot:coreDataSpot] autorelease];
            WMSpotData *spotData = [[[WMSpotData alloc] initWithEngineSpot:spot] autorelease];
            if (nil != spot  && nil != spotData)
            {
                [spotDatas addObject:spotData];
            }
        }
        if ([spotDatas count] > 0)
        {
            result = [NSArray arrayWithArray:spotDatas];
        }
    }
	
	return result;
}

- (void)resetCoreData:(NSArray *)spots
{
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDSpot" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [[self managedObjectContext] deleteObject:managedObject];
    }
    if (![[self managedObjectContext] save:&error])
    {
        [self.delegate spotSource:self didUpdateWithError:error];
    }
    else
    {
        for (WMSpot *spot in spots)
        {
            CDSpot *coreDataSpot = [[CDSpot alloc] initWithEntity:entity insertIntoManagedObjectContext:[self managedObjectContext]];
            [coreDataSpot setName:[spot name]];
            [coreDataSpot setPassword:[spot password]];
            [coreDataSpot setLatitude:[NSNumber numberWithDouble:[spot location].x]];
            [coreDataSpot setLongtitude:[NSNumber numberWithDouble:[spot location].y]];
            [coreDataSpot setSpotId:[NSNumber numberWithInteger:[spot spotId]]];
            [coreDataSpot setAuthor:[spot author]];
            [coreDataSpot setLikeCount:[NSNumber numberWithInteger:[spot likeCount]]];
            [[self managedObjectContext] insertObject:coreDataSpot];
        }
        [[self managedObjectContext] save:&error];
        [self.delegate spotSource:self didUpdateWithError:error];
    }
}

- (void)update
{
    NSURL *serverURL = [NSURL URLWithString:kWMServerURL];
    NSString *spotsJSON = [kWMSpotsKey stringByAppendingPathExtension:@"json"];
    NSURL *spotsURL = [serverURL URLByAppendingPathComponent:spotsJSON];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:spotsURL];
    [request setUserInfo:[NSDictionary dictionaryWithObject:kWMUpdaetRequestString forKey:kWMRequestTypeKey]];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *requestType = [request.userInfo valueForKey:kWMRequestTypeKey];
    if ([requestType isEqualToString:kWMUpdaetRequestString])
    {
        NSString *responseString = [request responseString];
        NSArray *spots = [self fetchSpotsFromResponseString:responseString];
        [self resetCoreData:spots];
    }
}

- (NSArray *)fetchSpotsFromResponseString:(NSString *)response
{
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    id responseObject = [parser objectWithString:response];
    NSMutableArray *spotObjects = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *spec in responseObject)
    {
        [spotObjects addObject:[WMSpot spotWithSpec:spec]];
    }
    return spotObjects;
}

@end
