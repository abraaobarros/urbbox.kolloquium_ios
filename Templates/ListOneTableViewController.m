//
//  ListOneTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 06/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ListOneTableViewController.h"

@interface ListOneTableViewController ()

@end

@implementation ListOneTableViewController

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
