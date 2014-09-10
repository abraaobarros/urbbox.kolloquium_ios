//
//  URLConnectHelper.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "KQURLConnectHelper.h"

@implementation KQURLConnectHelper

-(void) fetchContentAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
             startHandle:(void (^)(void))startHandler
            sucessHandler:(void (^)(NSDictionary *))sucessBlock{
    if (startHandler) {
        startHandler();
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            NSDictionary *data = [KQURLConnectHelper requestGet:[KQURLConnectHelper buildUrlWith:parameters] urlString:url];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (sucessBlock!=nil)
                    sucessBlock(data);
            });
        }@catch (NSException *exception) {
            NSLog(@"Error : %@",exception);
        }
        
    });

}

-(void) fetchContentAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
            startHandle:(void (^)(void))startHandler
            sucessHandler:(void (^)(NSDictionary *))sucessBlock
            errorHandler:(void (^)(void))errorBlock{
    if (startHandler) {
        startHandler();
    }
    @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                NSDictionary *data = [KQURLConnectHelper requestGet:[KQURLConnectHelper buildUrlWith:parameters] urlString:url];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (sucessBlock!=nil)
                        sucessBlock(data);
                });
            }@catch (NSException *exception) {
                errorBlock();
                NSLog(@"Error : %@",exception);
            }
            
        });
    }
    @catch (NSException *exception) {
        errorBlock();
        NSLog(@"Error : %@",exception);
    }
}

-(void) fetchDataAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
              startHandle:(void (^)(void))startHandler
            sucessHandler:(void (^)(NSData *))sucessBlock
             errorHandler:(void (^)(void))errorBlock{
    if (startHandler) {
        startHandler();
    }
    @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                NSData* data = [NSData dataWithContentsOfURL:
                                [NSURL URLWithString: [NSString stringWithFormat:@"%@",url]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (sucessBlock!=nil)
                        sucessBlock(data);
                });
            }@catch (NSException *exception) {
                errorBlock();
                NSLog(@"Error : %@",exception);
            }
            
        });
    }
    @catch (NSException *exception) {
        errorBlock();
        NSLog(@"Error : %@",exception);
    }
}

+ (NSDictionary *)requestPost:(NSString *)urlString post:(NSString *)post {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    
    //Criar Request
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSDictionary *data;
    data = [self buildPostForm:url request:request postLength:postLength postData:postData];
    
    NSLog(@"Foi feito uma requisição POST: %@?%@",urlString,post);
    return data;
}



+(NSDictionary *) postUrlWithParameters:(NSDictionary *) parameters toUrl:(NSString *)urlString{
    NSString *post;
    post = [self buildUrlWith:parameters];
    
    NSDictionary *data;
    data = [self requestPost:urlString post:post];
    return data;
    
}

+ (NSDictionary *)requestGet:(NSString *)get urlString:(NSString *)urlString {
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: [NSString stringWithFormat:@"%@?%@",urlString,get]]];
    
    NSError* error;
    NSDictionary * result;
    NSLog(@"Foi feito uma requisição GET: %@?%@",urlString,get);
    result = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    
    NSLog(@"Result: %@",result);
    
    return result;
}

+(NSDictionary *) getUrlWithParametersAssync:(NSDictionary *)parameters toUrl:(NSString *) urlString{
    
    NSString *get;
    get = [self buildUrlWith:parameters];
    
    NSDictionary *result;
    result = [self requestGet:get urlString:urlString];
    return result;
}

+ (NSString *)buildUrlWith:(NSDictionary *)parameters {
    
    NSString *get = @"";
    for(NSString* key in parameters){
        get = [get stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[parameters objectForKey:key]]];
    }
    return get;
}

+ (NSDictionary *)buildPostForm:(NSURL *)url request:(NSMutableURLRequest *)request postLength:(NSString *)postLength postData:(NSData *)postData {
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *data2=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:data2
                                                         options:kNilOptions
                                                           error:&error];
    return data;
}

+(NSData *) getDataFrom:(NSString *)url{
    
    NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: url]];
    return data;
}

@end
