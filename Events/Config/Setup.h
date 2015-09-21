//
//  SetupEvent.h
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface Setup : NSObject

+(Event *)getActualEvent;

+(id) getClassOf:(EventTab) tab;

@end
