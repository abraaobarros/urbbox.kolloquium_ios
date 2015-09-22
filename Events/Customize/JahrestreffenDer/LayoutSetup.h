//
//  LayoutSetup.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Layout.h"



@interface LayoutSetup : NSObject



+(Layout *) withTableViewAndWith:(CellLayout)cellLayout
                  andDetailsView:(DetailsLayout) datailsLayout
                           title:(NSString *)title
                          source:(NSString *)source;

@end
