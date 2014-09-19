//
//  ParticipantsTableViewCell.h
//  Events
//
//  Created by Abraao Barros Lacerda on 19/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParticipantsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *enterprise;
- (IBAction)send_email:(id)sender;

@end
