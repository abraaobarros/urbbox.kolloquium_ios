//
//  SideBarViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)schedule_tab:(id)sender;
- (IBAction)participants_tab:(id)sender;
- (IBAction)about_tab:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
