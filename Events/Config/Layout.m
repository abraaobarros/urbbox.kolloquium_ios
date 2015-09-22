//
//  Layout.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "Layout.h"
#import "KQEventAPI.h"


@implementation Layout

KQEventAPI *event;


-(instancetype) initWithTableViewAndWith:(CellLayout)cellLayout
                                     andDetailsView:(DetailsLayout) datailsLayout
                                              title:(NSString *)title
                                             source:(NSString *)source{
    
    self = [super init];
    if (self) {
        event =[[KQEventAPI alloc]
                initWithDataAssyncWithStart:^(void){
                    
                } finishProcess:^(void){
                    
                } errorHandler:^(void){
                    
                }];
        _source = source;
        _title = title;
        _cellLayout = cellLayout;
    
    }
    return self;
}


-(NSString *) cellIdentifier{
    
    switch (_cellLayout) {
        case ProgrammCellLayout:
            return @"ProgrammCellLayout";
            break;
            
        case TeilnehmerCellLayout:
            return @"TeilnehmerCellLayout";
            break;
            
        case ReferentenCellLayout:
            return @"ReferentenCellLayout";
            break;
            
        default:
            break;
    }
    return @"ProgrammCellLayout";
}

-(float) cellHeight{
    
    switch (_cellLayout) {
        case ProgrammCellLayout:
            return 161;
            break;
            
        case TeilnehmerCellLayout:
            return 52;
            break;
            
        case ReferentenCellLayout:
            return 126;
            break;
        case InstituteCellLayout:
            return 206;
            break;
        default:
            break;
    }
    return 100;
}


-(NSString *) segueIdentifier{
    
    return ProgrammDetailsLayout;

}

-(NSArray  *) datasource{
    
    NSArray *s = [_source componentsSeparatedByString:@"."];
    if ([s count] == 3)
        return [[[event objectForKey:[s objectAtIndex:0]]
                 objectAtIndex:[[s objectAtIndex:1] integerValue]]
                objectForKey:[s objectAtIndex:2]];
    return [event objectForKey:_source];
    
        

}

-(NSString *) navigationTitle{
    
    return _title;

}

-(NSString *)getFirstViewControllerIdentifier{

    return @"KQTableViewController";

}




@end
