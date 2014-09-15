//
//  URLConnectHelper.h
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KQURLConnectHelper : NSObject

-(void) fetchContentAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
              startHandle:(void (^)(void))startHandler
            sucessHandler:(void (^)(NSDictionary *))sucessBlock;

-(void) fetchContentAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
              startHandle:(void (^)(void))startHandler
            sucessHandler:(void (^)(NSDictionary *))sucessBlock
             errorHandler:(void (^)(void))errorBlock;

-(void) fetchDataAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
           startHandle:(void (^)(void))startHandler
         sucessHandler:(void (^)(NSData *))sucessBlock
          errorHandler:(void (^)(void))errorBlock;

-(void) postDataToURL:(NSString *)url withParameters:(NSDictionary *)parameters
          startHandle:(void (^)(void))startHandler
        sucessHandler:(void (^)(NSDictionary *))sucessBlock
         errorHandler:(void (^)(void))errorBlock;
@end
