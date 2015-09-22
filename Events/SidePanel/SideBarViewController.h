//
//  SideBarViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Setup.h"

@interface SideBarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) Event *eventTab;
@property (strong, nonatomic) NSDictionary *datasource;

@end
