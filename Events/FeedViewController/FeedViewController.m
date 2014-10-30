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
#import <MessageUI/MessageUI.h>
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
    [Util setupNavigationBar:self withTitle:@"Referenten"];
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
    cell.lblUserName.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.btnUserId.titleLabel.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"tel"];
    if ([[[dataSource objectAtIndex:indexPath.row] valueForKey:@"email"] isEqualToString: @""])
        cell.email.hidden= YES;
    else
        cell.email.hidden= NO;
        
    cell.lblViewComment.text=[NSString stringWithFormat:@"Tel: %@",[[dataSource objectAtIndex:indexPath.row] valueForKey:@"tel"]];
        
        return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (![[[dataSource objectAtIndex:indexPath.row] valueForKey:@"email"] isEqualToString: @""]){
//        if ([MFMailComposeViewController canSendMail]) {
//            
//            MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
//
//            NSArray *toRecipients = [NSArray arrayWithObjects:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"email"], nil];
//            [mailViewController setToRecipients:toRecipients];
//            mailViewController.mailComposeDelegate = self;
//            [self presentModalViewController:mailViewController animated:YES];
//        } else {
//            NSLog(@"Device is unable to send email in its current state.");
//        }
//    }
    
    // Get reference to the destination view controller
    SpeakerDetailsViewController *vc = (SpeakerDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SpeakerDetailsViewController"];
    NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
    vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
    [vc setData:data];
    
    [self.sidePanelController setRightFixedWidth:self.view.frame.size.width*9/10];
    [self.sidePanelController setMaximumAnimationDuration:0.5];
    [self.sidePanelController setRightPanel:vc];
    [self.sidePanelController showRightPanelAnimated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:NO completion:^{}];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"SpeakerDetailsViewController"])
    {
        // Get reference to the destination view controller
        SpeakerDetailsViewController *vc = (SpeakerDetailsViewController *)[segue destinationViewController];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
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
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
