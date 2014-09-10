//
//  KQURLConnectHelperMock.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "KQURLConnectHelperMock.h"

@implementation KQURLConnectHelperMock

-(void) fetchContentAtURL:(NSString *)url withParameters:(NSDictionary *)parameters
              startHandle:(void (^)(void))startHandler
            sucessHandler:(void (^)(NSDictionary *))sucessBlock{
    if (startHandler != nil) {
        startHandler();
    }
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    [d setObject:@"Nome" forKey:@"name"];
    if (sucessBlock != nil) {
        sucessBlock(d);
    }
    
}

@end
