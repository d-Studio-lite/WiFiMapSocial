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
#import "ASIHTTPRequest.h"
#import <CoreData/CoreData.h>

@interface WMSpotSource()<ASIHTTPRequestDelegate>

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

NSUInteger kMaxVerticalRowOfStopsLength = 20;
NSUInteger kMaxHorizontalRowOfStopsLength = 15;

- (NSArray *)spotDataArrayInRect:(CGRect)rect
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
        NSMutableArray *spotsDataArray = [NSMutableArray arrayWithCapacity:kMaxVerticalRowOfStopsLength * kMaxHorizontalRowOfStopsLength];
        for (NSUInteger i = kMaxVerticalRowOfStopsLength * kMaxHorizontalRowOfStopsLength; i > 0; --i)
        {
            [spotsDataArray addObject:[NSMutableArray array]];
        }
        
        CGFloat widthPerRect = rect.size.width / (CGFloat)kMaxHorizontalRowOfStopsLength;
        CGFloat heightPerRect = rect.size.height / (CGFloat)kMaxVerticalRowOfStopsLength;
        
        for (CDSpot *coreDataSpot in results)
        {
            WMSpot *spot = [[[WMSpot alloc] initWithCDSpot:coreDataSpot] autorelease];
            
            NSUInteger ix = (spot.location.x - rect.origin.x) / widthPerRect;
            NSUInteger iy = (spot.location.y - rect.origin.y) / heightPerRect;
            NSUInteger index = (iy * kMaxHorizontalRowOfStopsLength + ix);
            [(NSMutableArray *)[spotsDataArray objectAtIndex:index] addObject:spot];
        }
        
        BOOL (^ block)(id, NSDictionary *) = ^(id object, NSDictionary *binds) {
            NSArray *array = (NSArray *)object;
            return (BOOL)([array count] > 0);
        };

        NSPredicate *predicate = [NSPredicate predicateWithBlock:block];
        [spotsDataArray filterUsingPredicate:predicate];
        if ([spotsDataArray count] > 0)
        {
            result = [NSArray arrayWithArray:spotsDataArray];
        }
    }
	
	// Memory management.
	[fetchRequest release];
	
	return results;
}

- (void)update
{
    NSURL *serverURL = [NSURL URLWithString:kWMServerURL];
    NSString *spotsJSON = [kWMSpotsKey stringByAppendingPathExtension:@"json"];
    NSURL *spotsURL = [serverURL URLByAppendingPathComponent:spotsJSON];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:spotsURL];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    [self fetchSpotsFromResponseString:responseString];
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
