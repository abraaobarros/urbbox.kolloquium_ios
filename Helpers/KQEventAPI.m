//
//  EventAPI.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "KQEventAPI.h"
#import "KQURLConnectHelper.h"
#import "KQCache.h"

#define URL_EVENT @"http://kolloquium.herokuapp.com/rest/event/1"

@implementation KQEventAPI
@synthesize urlConnectHelper;
@synthesize data;

- (id)initWithDataAssyncWithStart:(void (^)(void))startHandler
                    finishProcess:(void (^)(void))finishHandler
                    errorHandler:(void (^)(void))errorHandler
{
    self = [super init];
    if (self)
    {
        urlConnectHelper = [[KQURLConnectHelper alloc ]init];
        [self loadData:finishHandler startHandler:startHandler errorHandler:errorHandler];
    }
    return self;
}

- (void)loadData:(void (^)())finishHandler
        startHandler:(void (^)())startHandler
        errorHandler:(void (^)())errorHandler

{
    KQCache *cache = [KQCache sharedManager];
    if ([cache getDataFromHash:URL_EVENT]==nil) {
        [urlConnectHelper fetchContentAtURL:URL_EVENT
                            withParameters:nil
                            startHandle:startHandler
                            sucessHandler:^(NSDictionary* finished){
                                data = [finished mutableCopy];
                                [cache putData:data toHash:URL_EVENT];
                                if (finishHandler!=nil) {
                                    finishHandler();
                                }
                                
                            } errorHandler:errorHandler];
        NSLog(@"Data DB fetched: %@",self.data);
    }else{
        if (startHandler!=nil) {
            startHandler();
        }
        self.data = [[cache getDataFromHash:URL_EVENT] mutableCopy];
        NSLog(@"Data DB fetchedaaa: %@",self.data);
        if (finishHandler!=nil) {
            finishHandler();
        }
    }
}

- (void)reloadData:(void (^)())finishHandler
    startHandler:(void (^)())startHandler
    errorHandler:(void (^)())errorHandler

{
    KQCache *cache = [KQCache sharedManager];
    [urlConnectHelper fetchContentAtURL:URL_EVENT
                             withParameters:nil
                                startHandle:startHandler
                              sucessHandler:^(NSDictionary* finished){
                                  data = [finished mutableCopy];
                                  [cache putData:data toHash:URL_EVENT];
                                  if (finishHandler!=nil) {
                                      finishHandler();
                                  }
                                  
                              } errorHandler:errorHandler];
}

- (void)getImageFromUrl:(NSString *)url
          finishHandler:(void (^)())finishHandler
           startHandler:(void (^)())startHandler
           errorHandler:(void (^)())errorHandler{
    
    KQCache *cache = [KQCache sharedManager];
    if ([cache getDataFromHash:url]==nil) {
        [urlConnectHelper fetchDataAtURL:url
                             withParameters:nil
                                startHandle:startHandler
                              sucessHandler:^(NSData* finished){
                                  data = [finished mutableCopy];
                                  [cache putData:data toHash:URL_EVENT];
                                  if (finishHandler!=nil) {
                                      finishHandler();
                                  }
                                  
                              } errorHandler:errorHandler];
        NSLog(@"Data DB fetched: %@",self.data);
    }else{
        if (startHandler!=nil) {
            startHandler();
        }
        self.data = [[cache getDataFromHash:url] mutableCopy];
        NSLog(@"Data DB fetchedaaa: %@",self.data);
        if (finishHandler!=nil) {
            finishHandler();
        }
    }
}


-(id)objectForKey:(id)aKey{
    return [data objectForKey:aKey];
}

@end
