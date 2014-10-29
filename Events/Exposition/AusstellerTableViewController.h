//
//  ExpositionTableViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KQURLConnectHelper.h"
#import "KQEventAPI.h"

@interface AusstellerTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate,UISearchDisplayDelegate>
@property (nonatomic, retain) KQURLConnectHelper * urlConnectHelper;
@property (nonatomic,weak) NSArray *dataSource;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) KQEventAPI *event;
@property (nonatomic,strong) NSString *data;
@property (nonatomic,strong) NSMutableDictionary *imagesCache;
@end
