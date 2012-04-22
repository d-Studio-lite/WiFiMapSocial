//
//  WMSpotBaloonView.m
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WMSpotBaloonView.h"
#import "FBLikeButton.h"
#import "WMSpot.h"

@interface WMSpotBaloonView()

@property (retain, nonatomic) UIButton *editButton;
@property (retain, nonatomic) FBLikeButton *likeButton;
@property (retain, nonatomic) WMSpot *spot;

@end

@implementation WMSpotBaloonView

@synthesize editButton = _editButton;
@synthesize likeButton = _likeButton;

@synthesize spot = _spot;

- (id)initWithFrame:(CGRect)frame spot:(WMSpot *)spot
{
    self = [self initWithFrame:frame];
    if (nil != self)
    {
        self.spot = spot;
        self.editButton = [[[UIButton alloc] initWithFrame:CGRectMake(16.0f, 0.0f, 32.0f, 32.0f)] autorelease];
        [self.editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        
        [self addSubview:self.editButton];
        
        
        self.likeButton = nil; //fix here with CGRectMake(0.0f, 0.0f, ???, ???)
        [self addSubview:self.likeButton];
    }
    return self;
}

- (void)dealloc
{
    self.editButton = nil;
    self.likeButton = nil;
    self.spot = nil;
    [super dealloc];
}

@end
