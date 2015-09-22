//
//  ProgrammLayoutCellTableViewCell.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutCell.h"

@interface ProgrammLayoutCellTableViewCell : LayoutCell

@property (weak, nonatomic) IBOutlet UIImageView *img_background;
@property (weak, nonatomic) IBOutlet UILabel *descr;
@property (weak, nonatomic) IBOutlet UILabel *speaker;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
