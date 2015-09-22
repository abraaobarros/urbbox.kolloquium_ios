//
//  ReferentenCellLayoutTableViewCell.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "ReferentenCellLayoutTableViewCell.h"

@implementation ReferentenCellLayoutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data{
 
    _title.text   = [data objectForKey:@"name"];
    _descrip.text = [data objectForKey:@"company"];
    
}

@end
