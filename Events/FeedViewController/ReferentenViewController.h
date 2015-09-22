//
//  FeedViewController.h
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KQURLConnectHelper.h"
#import "KQEventAPI.h"

@interface ReferentenViewController : UITableViewController

@property (nonatomic, retain) KQURLConnectHelper * urlConnectHelper;
@property (nonatomic,strong) NSArray *dataSource;
@property (strong, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic,strong) KQEventAPI *event;
@property (nonatomic,strong) NSMutableDictionary *imagesCache;


@end
