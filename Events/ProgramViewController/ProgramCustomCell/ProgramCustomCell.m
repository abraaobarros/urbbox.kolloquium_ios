//
//  ProgramCustomCell.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ProgramCustomCell.h"
#import "Util.h"

@implementation ProgramCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setData:(NSDictionary *)data{

    self.lblDateTime.text = [Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"dd/MM/yyyy HH:mm" toPattern:@"HH:mm "];
    self.lblEventName.text=[data valueForKey:@"subject"];
    self.lblEventDesc.text=[data valueForKey:@"descript"];
    
    //[cell.lblEventName sizeToFit];
    [self.lblEventDesc sizeToFit];
    self.data.text=[Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"dd/MM/yyyy HH:mm" toPattern:@"dd MMM"];
    @try {
        self.speaker.text = [[data valueForKey:@"speaker"] objectForKey:@"name"];
        
        if([[[data valueForKey:@"speaker"]objectForKey:@"name"] isEqualToString:@"Information"])
        {
            self.company.text=@"";
        }else
        {
            self.company.text=[[data valueForKey:@"speaker"] objectForKey:@"company"];
        }
    }
    @catch (NSException *exception) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.speaker.text = [NSString stringWithFormat:@"Ort: %@",[data valueForKey:@"location"]];
        } else {
            self.speaker.text = @"";
        }
        
        self.company.text = @"";
    }
    @finally {
        
    }
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {
        self.location.text = [NSString stringWithFormat:@"%@",[data valueForKey:@"location"]];
    }else{
        self.location.text = @"";
    }
    
    
    self.imgEventImage.image = nil;

}



@end
