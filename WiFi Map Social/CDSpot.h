//
//  CDSpot.h
//  WiFi Map Social
//
//  Created by Оксана Фелештинская on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDSpot : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longtitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;

@end
