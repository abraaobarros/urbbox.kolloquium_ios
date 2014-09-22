//
//  ExpositionTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ExpositionTableViewController.h"
#import "KQCache.h"
#import "FeedViewController.h"
#import "FeedCustomCell.h"
#import "SecondFeedCustomCell.h"
#import "ThirdFeedCustomCell.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "KQEventAPI.h"
#import "KQCache.h"
#import "SpeakerDetailsViewController.h"
#import "ProgramDetailsViewController.h"

@interface ExpositionTableViewController ()
{
    // NSMutableArray *arrFeedImages;
    NSMutableArray *dicTweetFeed;
    NSMutableArray *dicImageFeed;
    KQCache *cache;
    
}

@end

@implementation ExpositionTableViewController
@synthesize tableView;
@synthesize imagesCache;
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
    
    self.navigationItem.title = @"Werkzeugbau Mit Zukunft";
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    NSLog(@"_Event: %@",_event);
    
    cache = [KQCache sharedManager];
    _dataSource = [[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"guest_companies"];
    
}
-(void)dicDummyDataInitialization{
    _dataSource = [_event objectForKey:@"guest_companies"];
    
    NSLog(@"Lectures : %@",_dataSource);
    [tableView reloadData];
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
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        return 163;
    }
    else
    {
        return 120;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if (indexPath.row%2==0) {
    static NSString *CellIdentifier = @"";
    
    CellIdentifier = @"FeedCustomCell";
    
    FeedCustomCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[FeedCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.imgMainImage.image = [UIImage imageNamed:@"no_profile.png"];
    if ([imagesCache objectForKey:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"logo"]]!= nil ){
        cell.imgMainImage.image=[UIImage imageWithData: [imagesCache objectForKey:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"logo"]]];
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"logo"]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [imagesCache setObject:data forKey:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"logo"]];
                    cell.imgMainImage.image=[UIImage imageWithData: data];
                    [cache putDataSource:data toHash:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"logo"]];
                });
            }@catch (NSException *exception) {
                NSLog(@"Error : %@",exception);
            }
            
        });
    }
    cell.lblTweet.text=[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"short_descript"];
    [cell.lblTweet sizeToFit];
    cell.lblUserName.text=[[_dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];
//    cell.btnUserId.titleLabel.text=[[_dataSource objectAtIndex:indexPath.row/2] valueForKey:@"tel"];
    
//    cell.lblViewComment.text=[NSString stringWithFormat:@"Tel: %@",[[_dataSource objectAtIndex:indexPath.row/2] valueForKey:@"tel"]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {
        [self.sidePanelController setRightFixedWidth:300];
    }
    else
    {
        //        [self performSegueWithIdentifier:@"ProgramDetailsViewController" sender:self];
    }
    
    // Get reference to the destination view controller
    SpeakerDetailsViewController *vc = (SpeakerDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ExibitorsDetailsViewController"];
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    vc.data =[[NSDictionary alloc] initWithDictionary:[_dataSource objectAtIndex:ip.row]];
    [self.sidePanelController setRightPanel:vc];
    [self.sidePanelController showRightPanelAnimated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"SpeakerDetailsViewController"])
    {
        // Get reference to the destination view controller
        //        SpeakerDetailsViewController *vc = (SpeakerDetailsViewController *)[segue destinationViewController];
        //        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        //        NSLog(@"IP: %@",[_dataSource objectAtIndex:ip.row]);
        //        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[_dataSource objectAtIndex:ip.row]];
        //        vc.data =[[NSDictionary alloc] initWithDictionary:[_dataSource objectAtIndex:ip.row]];
        
        
        // Pass any objects to the view controller here, like...
    }
    
    if ([[segue identifier] isEqualToString:@"ProgramDetailsViewController"])
    {
        // Get reference to the destination view controller
        ProgramDetailsViewController *vc = (ProgramDetailsViewController *)[segue destinationViewController];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[_dataSource objectAtIndex:ip.row]);
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[_dataSource objectAtIndex:ip.row]];
        vc.data =[[NSDictionary alloc] initWithDictionary:[_dataSource objectAtIndex:ip.row]];
        
        
        // Pass any objects to the view controller here, like...
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
