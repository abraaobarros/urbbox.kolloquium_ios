//
//  SideBarViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "SideBarViewController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "KQSideBarTableViewCell.h"
#import "KQTabBarViewController.h"
#import "KQSectionTableViewCell.h"
#import "InstituteDetailTableViewController.h"
#import "Loading2ViewController.h"
#import "ProgramViewController.h"
#import "KQNavigationController.h"
#import "AusstellerTableViewController.h"
#import "AboutTableViewController.h"
#import "InfoViewController.h"
#import "GalerieViewController.h"
#import "KQGalleryCollectionViewController.h"
#import "KQCache.h"
#import "Util.h"
#import "Setup.h"


@interface SideBarViewController ()

@end

@implementation SideBarViewController

KQEventAPI *event;
NSArray *sections;
Event *eventTab;
NSDictionary *datasource;


- (void)viewDidLoad
{
    [super viewDidLoad];

    event =[[KQEventAPI alloc]
            initWithDataAssyncWithStart:^(void){
                NSLog(@"Init Fetching");
            } finishProcess:^(void){
                NSLog(@"Finish Fetching");
            } errorHandler:^(void){
                NSLog(@"Error Fetching");
            }];
    
    eventTab   = [Setup getActualEvent];
    sections   = [[eventTab getTabsEvent] allKeys];
    datasource = [eventTab getTabsEvent];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [sections count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return [[datasource objectForKey:[sections objectAtIndex:section]] count];

}

-(long) getTabFromIndex:(NSIndexPath *)indexPath{

    NSLog(@"%@",[[datasource objectForKey:
                 [sections objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]);
    
    long s = [[[datasource objectForKey:
                    [sections objectAtIndex:indexPath.section]]
               objectAtIndex:indexPath.row] longValue];
    return s;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"KQSideBarTableViewCell";
    KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.title.text = [eventTab getTitleOfTab:[self getTabFromIndex:indexPath]];
    cell.icon.image  = [eventTab getIconOfTab:[self getTabFromIndex:indexPath]];
    
    return cell;
    
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 43;
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"SectionHeader";
    
    KQSectionTableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    headerView.title.text = [sections objectAtIndex:section];
    
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if(indexPath.row==0)
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramViewController"]];
            }
            else
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramViewController"]];
            }
        }
        else if(indexPath.row==1)
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ParticipantsViewController"]];
            }
            else
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ParticipantsViewController"]];
                
            }
            
        }
        else if(indexPath.row==2)
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"]];
            }
            else
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"]];
                
            }
           
        }
        else if(indexPath.row==3)
        {
            AusstellerTableViewController *vc = (AusstellerTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ExpositionTableViewController"];
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [vc setData:@"guest_companies"];
            [self.sidePanelController setCenterPanel:partnersView];
        }
        else if(indexPath.row==4)
        {
            AboutTableViewController *vc = (AboutTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AboutTableViewController"];
            KQNavigationController *aboutView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [self.sidePanelController setCenterPanel:aboutView];
            
        }
        else if(indexPath.row==5)
            
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CompetitionViewController"]];
        }
        else if(indexPath.row==6)
        {
            AusstellerTableViewController *vc = (AusstellerTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ExpositionTableViewController"];
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [vc setData:@"competitors"];
            [self.sidePanelController setCenterPanel:partnersView];
        }
    }
    else if (indexPath.section==1){
        if(indexPath.row==0)
        {
            InstituteDetailTableViewController *vc = (InstituteDetailTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InstituteDetailTableViewController"];
            vc.title = @"IPT";
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [self.sidePanelController setCenterPanel:partnersView];
        }
        else if(indexPath.row==1)
        {
            InstituteDetailTableViewController *vc = (InstituteDetailTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InstituteDetailTableViewController"];
            vc.title = @"WZL";
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [self.sidePanelController setCenterPanel:partnersView];
           
        }
        else if(indexPath.row ==2){
            AusstellerTableViewController *vc = (AusstellerTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ExpositionTableViewController"];
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [vc setData:@"partners"];
            [self.sidePanelController setCenterPanel:partnersView];
        }
    }else if (indexPath.section==2){
        if(indexPath.row==0)
        {
            InfoViewController *vc = (InfoViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
            vc.title = @"Aachen";
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [self.sidePanelController setCenterPanel:partnersView];
            
            
        }
        if(indexPath.row==1){
            KQGalleryCollectionViewController *vc = (KQGalleryCollectionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"GalerieViewController"];
            KQNavigationController *partnersView = [[KQNavigationController alloc]initWithRootViewController:vc];
            [self.sidePanelController setCenterPanel:partnersView];
        }
        if(indexPath.row==2)
        {
            KQCache *cache = [KQCache sharedManager];
            [cache resetDatabase];
            KQNavigationController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ProgramViewController"];
            [self.sidePanelController setCenterPanel:vc];
            
            
        }
        else if(indexPath.row==4)
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:nil forKey:@"email"];
            [userDefaults synchronize];
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramViewController"]];
            
        }
        else if(indexPath.row==3)
        {
            CGRect webFrame = CGRectMake(0.0, 0.0, self.view.frame.size.width,self.view.frame.size.height);
            UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Impressum" ofType:@"pdf"];
            NSURL *targetURL = [NSURL fileURLWithPath:path];
            NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
            [webView loadRequest:request];
            
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view = webView;
            KQNavigationController *partnersView = [[KQNavigationController alloc] initWithRootViewController:vc];
            [Util setupNavigationBar:vc withTitle:@"Impressum"];
            vc.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:155.0/255.0 green:0.0 blue:32.0/255.0 alpha:1];
            [self.sidePanelController setCenterPanel:partnersView];
        }
    }
    
}

@end
