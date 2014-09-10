//
//  KQCache.h
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cache.h"

@interface KQCache : NSObject{
}

@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, strong) NSMutableDictionary *dataSource;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (id)sharedManager;
- (NSDictionary *) getDataFromHash: (NSString *) hash;
- (NSData *) getDataSourceFromHash: (NSString *) hash;
- (void) putData: (NSDictionary *) dado toHash:(NSString *)hash;
- (void) putDataSource: (NSData *) dado toHash:(NSString *)hash;

@end
