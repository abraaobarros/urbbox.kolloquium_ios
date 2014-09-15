//
//  KQCache.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "KQCache.h"
#import "AppDelegate.h"

@implementation KQCache
@synthesize data;
@synthesize dataSource;
@synthesize managedObjectContext;

+ (id)sharedManager {
    static KQCache *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init]; 
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        data = [[NSMutableDictionary alloc] init];
        dataSource = [[NSMutableDictionary alloc] init];
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        managedObjectContext = appDelegate.managedObjectContext;
        [self loadData];
    }
    return self;
}

- (NSDictionary *) getDataFromHash: (NSString *) hash{
    @try {
        return [data objectForKey:hash];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (NSData *) getDataSourceFromHash: (NSString *) hash{
    @try {
        return [dataSource objectForKey:hash];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

-(void) putData: (NSDictionary *) dado toHash:(NSString *)hash{
    [self.data setValue:dado forKey:hash];
    [self save:dado toHash:hash];
    //    [self saveData];
}

-(void) putDataSource: (NSData *) dado toHash:(NSString *)hash{
    [self.dataSource setValue:dado forKey:hash];

    Cache* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Cache"
                                                    inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.url = hash;
    newEntry.cache = [self.dataSource objectForKey:hash]; ;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (void) save: (NSDictionary *) dado toHash:(NSString *)hash{
    // Add Entry to PhoneBook Data base and reset all fields
    
    //  1
    Cache* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Cache"
                                                      inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.url = hash;
    newEntry.cache = [NSKeyedArchiver archivedDataWithRootObject:[data objectForKey:hash]]; ;
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(void) loadData{
    
    // initializing NSFetchRequest
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    managedObjectContext = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cache"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (Cache *c in fetchedRecords) {
        
            @try {
                if ([NSKeyedUnarchiver unarchiveObjectWithData:c.cache]!=nil) {
                    [data setObject:(NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:c.cache] forKey:c.url];
                }
            }
            @catch (NSException *exception) {
                [dataSource setObject:c.cache forKey:c.url];
            }
    }
//    NSLog(@"DB :%@",data);
    

}


@end
