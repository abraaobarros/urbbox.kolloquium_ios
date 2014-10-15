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
#import <MessageUI/MessageUI.h>
#import "Util.h"

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
    
    
    [Util setupNavigationBar:self withTitle:@"Werkzeugbau Mit Zukunft"];
    
    
    filteredArray = [[NSMutableArray alloc] init];
    
    cache = [KQCache sharedManager];
    
    _dataSource = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"participants"] mutableCopy];
    filteredArray = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"participants"] mutableCopy];

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
//        [mailViewController setSubject:@"Subject Goes Here."];
//        [mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
       
        NSArray *toRecipients = [NSArray arrayWithObjects:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"email"], nil];
        [mailViewController setToRecipients:toRecipients];
        mailViewController.mailComposeDelegate =self;
        [self presentModalViewController:mailViewController animated:YES];
    } else {
        NSLog(@"Device is unable to send email in its current state.");
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ OR company CONTAINS[c] %@", searchText, searchText];
   filteredArray = [_dataSource filteredArrayUsingPredicate:pred];
    
    
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
