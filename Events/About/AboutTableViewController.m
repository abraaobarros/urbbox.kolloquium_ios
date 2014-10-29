//
//  AboutTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 26/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//


#import "UIViewController+JASidePanel.h"
#import "KQCache.h"
#import "Util.h"
#import "AboutTableViewController.h"

@interface AboutTableViewController ()

@end

@implementation AboutTableViewController
@synthesize tableView;

KQCache *cache;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [Util setupNavigationBar:self withTitle:@"Kolloquium"];
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithRed:44.0/256.0 green:57.0/256.0 blue:69.0/256.0 alpha:1];
    [tableView setBackgroundView:bview];
    
    cache = [KQCache sharedManager];
    NSDictionary *d = [cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"];
    _about.text = [d objectForKey:@"descript"];
    [_about sizeToFit];
    
    _address.text = [d objectForKey:@"address"];
    
    _dates.text = @"5. Nov. 2014 08:30 - 16:00";
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

@end
