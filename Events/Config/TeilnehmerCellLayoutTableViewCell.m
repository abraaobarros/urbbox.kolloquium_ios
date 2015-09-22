//
//  TeilnehmerCellLayoutTableViewCell.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "TeilnehmerCellLayoutTableViewCell.h"

@implementation TeilnehmerCellLayoutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setData:(NSDictionary *)data{

    _name.text = [data objectForKey:@"name"];
    _company.text = [data objectForKey:@"company"];


}
@end
