//
//  WMDataController.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 21.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMDataController.h"
#import "WMSpotSource.h"

@interface WMDataController()

@property (retain, nonatomic) WMSpotSource *spotSource;

@end

@implementation WMDataController

@synthesize spotSource = _spotSource;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (nil != self)
    {
        self.spotSource = [[[WMSpotSource alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc
{
    self.spotSource = nil;
    self.delegate = nil;
    [super dealloc];
}

- (void)update
{
    //[[self spotSource] update];
}

@end
