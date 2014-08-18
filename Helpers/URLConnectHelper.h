//
//  URLConnectHelper.h
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLConnectHelper : NSObject


+(NSDictionary *) postUrlWithParametersAssync:(NSDictionary *) parameter toUrl:(NSString *)urlString;

+(NSDictionary *) getUrlWithParametersAssync:(NSDictionary *) parameters toUrl:(NSString *) urlString;
+(NSData *) getDataFrom:(NSString *)url;

+(NSDictionary *)requestGet:(NSString *)get urlString:(NSString *)urlString;
+(NSDictionary *)requestPost:(NSString *)urlString post:(NSString *)post;
@end
