//
//  Util.h
//  Events
//
//  Created by Abraao Barros Lacerda on 10/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+(NSString *) convertDataFormat:(NSString *) data withPattern:(NSString *) from toPattern:(NSString *) to;

+(void) setupNavigationBar:(UIViewController *)nav withTitle:(NSString *) title;

+(NSString *)stripTags:(NSString *)str;
@end
