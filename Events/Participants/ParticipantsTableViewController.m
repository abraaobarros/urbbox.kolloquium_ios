//
//  ParticipantsTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 19/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ParticipantsTableViewController.h"
#import "UIViewController+JASidePanel.h"
#import "ParticipantsTableViewCell.h"
#import "KQCache.h"

@interface ParticipantsTableViewController (){
    KQCache *cache;
}


@end

@implementation ParticipantsTableViewController

@synthesize filteredArray;

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
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    
    self.navigationItem.title = @"Werkzeugbau Mit Zukunft";
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    
    filteredArray = [[NSMutableArray alloc] init];
    
    cache = [KQCache sharedManager];
    
    _dataSource = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"speakers"] mutableCopy];
    filteredArray = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"speakers"] mutableCopy];
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
        return [_dataSource count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ParticipantsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParticipantsTableCell" forIndexPath:indexPath];
    
    ParticipantsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParticipantsTableCell" ];
    
    if(!cell)
    {
        cell = [[ParticipantsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ParticipantsTableCell"];
    }
    
    
    NSDictionary *data;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        data = [filteredArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [data objectForKey:@"name"];
        cell.detailTextLabel.text = [data objectForKey:@"company"];
    } else {
        data = [_dataSource objectAtIndex:indexPath.row];
    }
    
    cell.name.text = [data objectForKey:@"name"];
    
    cell.enterprise.text = [data objectForKey:@"company"];
    
    return cell;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
//    _filteredArray  = [[NSMutableArray alloc] init];
    // Filter the array using NSPredicate
//    for (NSDictionary *dict in _dataSource) {
//        if ([[dict objectForKey:@"name"] rangeOfString:searchText].location != NSNotFound  ) {
//            [_filteredArray addObject:dict];
//        }
//    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ OR company CONTAINS[c] %@", searchText, searchText];
   filteredArray = [_dataSource filteredArrayUsingPredicate:pred];
    
    

//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name contains[c] %@ OR self.company contains[c] %@",searchText,searchText];
//    _filteredArray = [NSMutableArray arrayWithArray:[_dataSource filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
