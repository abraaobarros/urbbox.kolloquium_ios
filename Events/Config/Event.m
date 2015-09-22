//
//  Event.m
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "Event.h"

@implementation Event

-(NSString *)getTitleOfTab:(long)tab{
    
    return @"New Tab";

}

-(UIImage *)getIconOfTab:(long)tab{

    return [UIImage imageNamed:@"ic_thumbnail.png"];

}


@end
