//
//  SetupEvent.m
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "Setup.h"
#import "Event.h"
#import "JahrestreffenDerWBASetupEvent.h"

@implementation Setup

+(Event *)getActualEvent{
    
    return [[JahrestreffenDerWBASetupEvent alloc] init];
    
}

+(id) getClassOf:(EventTab) tab{
    
    return [[NSClassFromString(@"NameofClass") alloc] init];
}

@end
