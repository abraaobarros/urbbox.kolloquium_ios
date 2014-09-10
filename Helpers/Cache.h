//
//  Cache.h
//  Events
//
//  Created by Abraao Barros Lacerda on 19/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cache : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * cache;

@end
