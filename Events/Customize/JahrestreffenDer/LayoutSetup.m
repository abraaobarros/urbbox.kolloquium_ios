//
//  LayoutSetup.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "LayoutSetup.h"

@implementation LayoutSetup

+(Layout *) withTableViewAndWith:(CellLayout)cellLayout
                  andDetailsView:(DetailsLayout) detailsLayout
                           title:(NSString *)title
                          source:(NSString *)source{
    
    return [[Layout alloc] initWithTableViewAndWith:cellLayout andDetailsView:detailsLayout title:title source:source];

}

@end
