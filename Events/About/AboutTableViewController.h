//
//  AboutTableViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 26/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *about;
@property (weak, nonatomic) IBOutlet UILabel *dates;
@property (weak, nonatomic) IBOutlet UITableViewCell *about_cell;
@end
