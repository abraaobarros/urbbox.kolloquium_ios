//
//  ParticipantsTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 19/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "TeilnehmerTableViewController.h"
#import "UIViewController+JASidePanel.h"
#import "TeilnehmerTableViewCell.h"
#import "KQCache.h"

#import "Util.h"

@interface TeilnehmerTableViewController (){
    KQCache *cache;
}


@end

@implementation TeilnehmerTableViewController

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
    
    
    [Util setupNavigationBar:self withTitle:@"Teilnehmer"];
    
    
    filteredArray = [[NSMutableArray alloc] init];
    
    cache = [KQCache sharedManager];
    
    _dataSource = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"participants"] mutableCopy];
    filteredArray = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"participants"] mutableCopy];
    NSArray *retorno = [[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"participants"] mutableCopy];
    retorno = [retorno sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDictionary *first =(NSDictionary*)a;
        NSDictionary *second = (NSDictionary*)b;
        NSString *companyA = [first objectForKey:@"company"];
        NSString *companyB = [second objectForKey:@"company"];
        return [companyA compare:companyB];
    }];
    _dataSource = [[NSMutableArray alloc] initWithArray:retorno];
    filteredArray = [[NSMutableArray alloc] initWithArray:retorno];
    NSLog(@"Companies : %@",_dataSource);
    

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
    
    TeilnehmerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParticipantsTableCell" ];
    
    if(!cell)
    {
        cell = [[TeilnehmerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ParticipantsTableCell"];
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

//    if ([MFMailComposeViewController canSendMail]) {
//        
//        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
//        [mailViewController setSubject:@"Kontakt Werkzeugbau mit Zukunft"];
//        [mailViewController setMessageBody:@"" isHTML:NO];
//       
//        NSArray *toRecipients = [NSArray arrayWithObjects:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"email"], nil];
//        
//        
//        [mailViewController setToRecipients:toRecipients];
//        
//        mailViewController.mailComposeDelegate =self;
////        [self presentModalViewController:mailViewController animated:YES];
//        
//        [self presentViewController:mailViewController animated:YES completion:^{
//            
//        }];
//    } else {
//        NSLog(@"Device is unable to send email in its current state.");
//    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
