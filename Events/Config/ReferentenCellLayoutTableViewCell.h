//
//  ReferentenCellLayoutTableViewCell.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutCell.h"

@interface ReferentenCellLayoutTableViewCell : LayoutCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *descrip;

@end
