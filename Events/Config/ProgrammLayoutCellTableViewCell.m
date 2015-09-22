//
//  ProgrammLayoutCellTableViewCell.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "ProgrammLayoutCellTableViewCell.h"
#import "KQEventAPI.h"
#import "Util.h"

@implementation ProgrammLayoutCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setData:(NSDictionary *)data{
    
    @try {
        self.speaker.text = [[data valueForKey:@"speaker"] objectForKey:@"name"];
        
        if([[[data valueForKey:@"speaker"]objectForKey:@"name"] isEqualToString:@"Information"])
        {
            self.location.text=@"";
        }else
        {
            self.location.text=[[data valueForKey:@"speaker"] objectForKey:@"company"];
        }
    }
    @catch (NSException *exception) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.speaker.text = [NSString stringWithFormat:@"Ort: %@",[data valueForKey:@"location"]];
        } else {
            self.speaker.text = @"";
        }
        
        self.location.text = @"";
    }
    _descr.text    = [data objectForKey:@"subject"];
    @try {
        _location.text = [data objectForKey:@"location"];
    }
    @catch (NSException *exception) {
        _location.text = @"";
    }

    
    _time.text     = [Util convertDataFormat:[data objectForKey:@"date"] withPattern:@"dd/mm/yyyy HH:mm" toPattern:@"HH:mm"];
    
    
    [self loadImage:[data objectForKey:@"thumb"]];

}

-(void) loadImage:(NSString *)url{

    [KQEventAPI getImageFromUrl:url finishHandler:^(NSData* d){
        
        self.img_background.image=[UIImage imageWithData:d];
        
        
    } startHandler:^{
        
        NSLog(@"Init Image loader");
        
        
    } errorHandler:^{
        
        
        NSLog(@"Problem Image loader");
        
        
    }];
    
}

@end
