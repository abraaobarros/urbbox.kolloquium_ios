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
#define URL_LOGIN @"http://kolloquium.herokuapp.com/rest/login"

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

+ (void)makeLogin:(NSString *)login withPass:(NSString *)pass finishHandler:(void (^)())finishHandler
    startHandler:(void (^)())startHandler
    errorHandler:(void (^)())errorHandler
    loginErrorHandler:(void(^)())loginErrorHandler
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"emai+"]) {
        startHandler();
        finishHandler();
    }else{
        NSMutableDictionary *dados = [[NSMutableDictionary alloc] init];
        [dados setObject:login forKey:@"email"];
        [dados setObject:pass forKey:@"password"];
        KQURLConnectHelper *conn = [[KQURLConnectHelper alloc]init];
        [conn postDataToURL:URL_LOGIN withParameters:dados
                            startHandle:startHandler
                            sucessHandler:^(NSDictionary* finished){
                              NSMutableDictionary * data;
                                NSLog(@"Data Login Post: %@",data);
                              data = [finished mutableCopy];
                              @try {
                                  [userDefaults setObject:[finished objectForKey:@"id"] forKey:@"id"];
                                  [userDefaults setObject:[finished objectForKey:@"name"] forKey:@"name"];
                                  [userDefaults setObject:[finished objectForKey:@"company"] forKey:@"company"];
                                  [userDefaults setObject:[finished objectForKey:@"email"] forKey:@"email"];
                                  [userDefaults synchronize];
                                  if (![finished objectForKey:@"id"] ) {
                                      loginErrorHandler();
                                  }
                                  else if (finishHandler!=nil) {
                                      finishHandler();
                                  }
                              }
                              @catch (NSException *exception) {
                                  loginErrorHandler();
                              }
//                              }
                          } errorHandler:errorHandler];
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
          finishHandler:(void (^)(NSData *))finishHandler
           startHandler:(void (^)())startHandler
           errorHandler:(void (^)())errorHandler{
    
    KQCache *cache = [KQCache sharedManager];
    if ([cache getDataFromHash:url]==nil) {
        [urlConnectHelper fetchDataAtURL:url
                             withParameters:nil
                                startHandle:startHandler
                              sucessHandler:^(NSData* finished){
                                  
                                  if (finishHandler!=nil) {
                                      [cache putDataSource:finished toHash:url];
                                      finishHandler(finished);

                                  }
                                  
                              } errorHandler:errorHandler];
    }else{
        if (startHandler!=nil) {
            startHandler();
        }
        if (finishHandler!=nil) {
            finishHandler([cache getDataSourceFromHash:url]);
        }
    }
}


-(id)objectForKey:(id)aKey{
    return [data objectForKey:aKey];
}

@end
