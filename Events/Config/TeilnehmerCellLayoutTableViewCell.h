//
//  TeilnehmerCellLayoutTableViewCell.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutCell.h"

@interface TeilnehmerCellLayoutTableViewCell : LayoutCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *company;

@end
