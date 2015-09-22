//
//  Layout.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    ProgrammCellLayout,
    TeilnehmerCellLayout,
    ReferentenCellLayout,
    InstituteCellLayout
} CellLayout;

typedef enum : NSUInteger {
    ProgrammDetailsLayout,
    TeilnehmerDetailsLayout,
    ReferentenDetailsLayout,
} DetailsLayout;


@interface Layout : NSObject
-(instancetype) initWithTableViewAndWith:(CellLayout)cellLayout andDetailsView:(DetailsLayout) datailsLayout title:(NSString *)title source:(NSString *)source;

@property(nonatomic, strong) NSString *source;
@property(nonatomic, strong) NSString *title;
@property(nonatomic) CellLayout cellLayout;

-(NSString *) cellIdentifier;
-(float     ) cellHeight;
-(NSString *) segueIdentifier;
-(NSArray  *) datasource;
-(NSString *) navigationTitle;
-(NSString *) getFirstViewControllerIdentifier;

@end
