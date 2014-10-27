//
//  InstituteDetailTableViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 08/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"

@interface InstituteDetailTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSString *title;
@property (nonatomic) NSInteger *index;
@end
