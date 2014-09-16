//
//  KQSectionTableViewCell.m
//  Events
//
//  Created by Abraao Barros Lacerda on 16/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "KQSectionTableViewCell.h"

@implementation KQSectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
