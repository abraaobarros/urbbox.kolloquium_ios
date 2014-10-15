//
//  FeedViewController.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCustomCell.h"
#import "SecondFeedCustomCell.h"
#import "ThirdFeedCustomCell.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "KQEventAPI.h"
#import "KQCache.h"
#import "Util.h"
#import "SpeakerDetailsViewController.h"
#import "ProgramDetailsViewController.h"

@interface FeedViewController ()
{
    // NSMutableArray *arrFeedImages;
    NSMutableArray *dicTweetFeed;
    NSMutableArray *dicImageFeed;
    KQCache *cache;
}

@end

@implementation FeedViewController
@synthesize tableView;
@synthesize imagesCache;
@synthesize dataSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    [Util setupNavigationBar:self withTitle:@"Werkzeugbau Mit Zukunft"];
    cache = [KQCache sharedManager];
    dataSource = [[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"speakers"];
    
}
-(void)dicDummyDataInitialization{
    dataSource = [_event objectForKey:@"speakers"];
    
    NSLog(@"Lectures : %@",dataSource);
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
    return dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        return 108;
    }
    else
    {
        return 120;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier = @"";

        CellIdentifier = @"FeedCustomCell";
        
        FeedCustomCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell)
        {
            cell = [[FeedCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }

        [KQEventAPI getImageFromUrl:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"profile_img"]
                       finishHandler:^(NSData *data) {
                          cell.imgMainImage.image=[UIImage imageWithData: data];
                       }
                       startHandler:^{
                           
                       } errorHandler:^{
                           
                       }];
    cell.lblTweet.text=[[dataSource objectAtIndex:indexPath.row] objectForKey:@"company"];
    [cell.lblTweet sizeToFit];
    cell.lblUserName.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.btnUserId.titleLabel.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"tel"];
        
    cell.lblViewComment.text=[NSString stringWithFormat:@"Tel: %@",[[dataSource objectAtIndex:indexPath.row] valueForKey:@"tel"]];
        
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
    
    SpeakerDetailsViewController *vc = (SpeakerDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SpeakerDetailsViewController"];
    NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
    vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
    [vc setData:data];
    [self.sidePanelController setRightFixedWidth:600];
    [self.sidePanelController setRightPanel:vc];
    [self.sidePanelController showRightPanelAnimated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"SpeakerDetailsViewController"])
    {
        // Get reference to the destination view controller
        SpeakerDetailsViewController *vc = (SpeakerDetailsViewController *)[segue destinationViewController];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        
        
        // Pass any objects to the view controller here, like...
    }
    
    if ([[segue identifier] isEqualToString:@"ProgramDetailsViewController"])
    {
        // Get reference to the destination view controller
        ProgramDetailsViewController *vc = (ProgramDetailsViewController *)[segue destinationViewController];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        [vc setData:data];
//        vc.data =[[NSDictionary alloc] initWithDictionary:[_dataSource objectAtIndex:ip.row]];
        
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
