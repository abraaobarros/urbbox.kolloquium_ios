//
//  ExpositionTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AusstellerTableViewController.h"
#import "KQCache.h"
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
#import "AusstellerDetailsViewController.h"

@interface AusstellerTableViewController ()
{
    // NSMutableArray *arrFeedImages;
    NSMutableArray *dicTweetFeed;
    NSMutableArray *dicImageFeed;
    KQCache *cache;
    AusstellerDetailsViewController *vc;
    
    
}

@end

@implementation AusstellerTableViewController
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

    
    [Util setupNavigationBar:self withTitle:@"Aussteller"];
    
    vc = (AusstellerDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ExibitorsDetailsViewController"];
    [self.sidePanelController setRightPanel:vc];
    [self.sidePanelController setRightFixedWidth:self.view.frame.size.width*9/10];
    
    cache = [KQCache sharedManager];
    dataSource = [[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:_data];
    if ([_data isEqualToString:@"competitors"]) {
        dataSource = [[[[cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"] objectForKey:@"competitions"] objectAtIndex:0] objectForKey:@"competitors"];
        [Util setupNavigationBar:self withTitle:@"Finalisten"];
    }else if([_data isEqualToString:@"partners"]){
        [Util setupNavigationBar:self withTitle:@"Partners"];
    }
}
-(void)dicDummyDataInitialization{
    dataSource = [_event objectForKey:@"guest_companies"];
    
    NSLog(@"Exhibitors : %@",dataSource);
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
    
    FeedCustomCell *cell = [tableview dequeueReusableCellWithIdentifier:@"FeedCustomCell" forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[FeedCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FeedCustomCell"];
    }
    
    cell.imgMainImage.image = [UIImage imageNamed:@"no_profile.png"];
    @try{
        [KQEventAPI getImageFromUrl:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"logo"] finishHandler:^(NSData* data){
            @try {
                cell.imgMainImage.image=[UIImage imageWithData:data];
            }
            @catch (NSException *exception) {
            
            }
        
        } startHandler:^{
        
        } errorHandler:^{
        }];
    }
    @catch(NSException *exception){
    }
    
    
    @try {
        cell.lblTweet.text=[[dataSource objectAtIndex:indexPath.row] objectForKey:@"short_descript"];
        if ([_data isEqualToString:@"competitors"]) {
            cell.lblTweet.text=[[dataSource objectAtIndex:indexPath.row] objectForKey:@"profile"];
        }
        [cell.lblTweet sizeToFit];
        cell.lblUserName.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];

    }
    @catch (NSException *exception) {
        
    }
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
    [vc setData:data];
    [self.sidePanelController showRightPanelAnimated:YES];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"SpeakerDetailsViewController"])
    {

    }
    
    if ([[segue identifier] isEqualToString:@"ProgramDetailsViewController"])
    {
        ProgramDetailsViewController *vc = (ProgramDetailsViewController *)[segue destinationViewController];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
        vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        
    }
}


@end
