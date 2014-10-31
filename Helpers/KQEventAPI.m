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
#define URL_QUESTION @"http://kolloquium.herokuapp.com/rest/question"
#define URL_REVIEW @"http://kolloquium.herokuapp.com/rest/rating"

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
    if ([userDefaults objectForKey:@"email"]) {
        startHandler();
        finishHandler();
    }else{
        startHandler();
        NSMutableDictionary *dados = [[NSMutableDictionary alloc] init];
        [dados setObject:login forKey:@"email"];
        [dados setObject:pass forKey:@"password"];
        finishHandler();
//        KQURLConnectHelper *conn = [[KQURLConnectHelper alloc]init];
//        [conn postDataToURL:URL_LOGIN withParameters:dados
//                            startHandle:startHandler
//                            sucessHandler:^(NSDictionary* finished){
//                              NSMutableDictionary * data;
//                              data = [finished mutableCopy];
//                                if (data==nil) {
//                                    errorHandler();
//                                }
//                              @try {
//                                  [userDefaults setObject:[finished objectForKey:@"id"] forKey:@"id"];
//                                  [userDefaults setObject:[finished objectForKey:@"name"] forKey:@"name"];
//                                  [userDefaults setObject:[finished objectForKey:@"company"] forKey:@"company"];
//                                  [userDefaults setObject:[finished objectForKey:@"email"] forKey:@"email"];
//                                  [userDefaults synchronize];
//                                  if (![finished objectForKey:@"id"] ) {
//                                      loginErrorHandler();
//                                  }
//                                  else if (finishHandler!=nil) {
//                                      finishHandler();
//                                  }
//                              }
//                              @catch (NSException *exception) {
//                                  errorHandler();
//                              }
//                          } errorHandler:errorHandler];
    }
}

+ (void)makeQuestion:(NSString *)question toActivity:(int)activity_id withParticipant:(int) participant_id finishHandler:(void (^)())finishHandler
     startHandler:(void (^)())startHandler
     errorHandler:(void (^)())errorHandler
{
    
        NSMutableDictionary *dados = [[NSMutableDictionary alloc] init];
        [dados setObject:question forKey:@"question"];
        [dados setObject:@(activity_id) forKey:@"activity_id"];
        [dados setObject:@(participant_id) forKey:@"participant_id"];
        KQURLConnectHelper *conn = [[KQURLConnectHelper alloc]init];
        [conn postDataToURL:URL_QUESTION withParameters:dados
                startHandle:startHandler
              sucessHandler:^(NSDictionary* finished){
                  NSMutableDictionary * data;
                  NSLog(@"Question: %@",data);
                  data = [finished mutableCopy];
                  @try {
                      if (finishHandler!=nil) {
                          finishHandler();
                      }
                  }
                  @catch (NSException *exception) {
                      errorHandler();
                  }
              } errorHandler:errorHandler];
}

+ (void)makeReview:(NSString *)review withScore:(int) value toActivity:(int)activity_id withParticipant:(int) participant_id finishHandler:(void (^)())finishHandler
        startHandler:(void (^)())startHandler
        errorHandler:(void (^)())errorHandler
{
    
    NSMutableDictionary *dados = [[NSMutableDictionary alloc] init];
    [dados setObject:review forKey:@"review"];
    [dados setObject:@(value) forKey:@"value"];
    [dados setObject:@(activity_id) forKey:@"activity_id"];
    [dados setObject:@(participant_id) forKey:@"participant_id"];
    KQURLConnectHelper *conn = [[KQURLConnectHelper alloc]init];
    [conn postDataToURL:URL_REVIEW withParameters:dados
            startHandle:startHandler
          sucessHandler:^(NSDictionary* finished){
              NSMutableDictionary * data;
              NSLog(@"Question: %@",data);
              data = [finished mutableCopy];
              @try {
                  if (finishHandler!=nil) {
                      finishHandler();
                  }
              }
              @catch (NSException *exception) {
                  errorHandler();
              }
          } errorHandler:errorHandler];
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

+ (void)getImageFromUrl:(NSString *)url
          finishHandler:(void (^)(NSData *))finishHandler
           startHandler:(void (^)())startHandler
           errorHandler:(void (^)())errorHandler{
    
    KQCache *cache = [KQCache sharedManager];
    if ([cache getDataSourceFromHash:url]==nil) {
        KQURLConnectHelper *urlConnectHelper = [[KQURLConnectHelper alloc]init];
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
