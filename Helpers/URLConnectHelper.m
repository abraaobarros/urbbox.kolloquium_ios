//
//  URLConnectHelper.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "URLConnectHelper.h"

@implementation URLConnectHelper


+ (NSDictionary *)requestPost:(NSString *)urlString post:(NSString *)post {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    
    //Criar Request
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
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
    
    NSLog(@"Foi feito uma requisição POST: @%?%@",urlString,post);
    return data;
}

+(NSDictionary *) postUrlWithParametersAssync:(NSDictionary *) parameter toUrl:(NSString *)urlString withCache:(BOOL) cache{
    
    // Criar os parametros que serão enviados
    NSString *post = @"";
    for(NSString* key in parameter){
        post = [post stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[parameter objectForKey:key]]];
    }
    
    NSDictionary *data;
    data = [self requestPost:urlString post:post];
    return data;
    
}

+ (NSDictionary *)requestGet:(NSString *)get urlString:(NSString *)urlString {
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: [NSString stringWithFormat:@"%@?%@",urlString,get]]];
    
    NSLog(@"Url: %@",[NSString stringWithFormat:@"%@?%@",urlString,get]);
    NSError* error;
    NSDictionary * result;

    result = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    
    
    NSLog(@"Foi feito uma requisição GET: @%?%@",urlString,get);
    return result;
}

// get

+(NSDictionary *) getUrlWithParametersAssync:(NSDictionary *)parameters toUrl:(NSString *) urlString withCache:(BOOL) cache{
    
    // Criar os parametros que serão enviados
    NSString *get = @"";
    for(NSString* key in parameters){
        get = [get stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[[parameters objectForKey:key] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding]]];
    }
    
    
   
    
    NSDictionary *result;
    result = [self requestGet:get urlString:urlString];
    return result;
}


+(NSData *) getDataFrom:(NSString *)url{
    
    NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: url]];
        
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:data,@"data",nil];
    return data;
}

@end
