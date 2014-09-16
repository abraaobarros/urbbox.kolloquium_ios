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

@interface SideBarViewController ()

@end

@implementation SideBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)schedule_tab:(id)sender {
    NSLog(@"1");
    [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramViewController"]];

}

- (IBAction)participants_tab:(id)sender {
    NSLog(@"2");
    [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"]];
}

- (IBAction)about_tab:(id)sender {
    NSLog(@"3");
    [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"]];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 7;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if(indexPath.row==0)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Programm";
            cell.icon.image = [UIImage imageNamed:@"ic_action_schedule.png"];
            return cell;
        }
        else if(indexPath.row==1)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Teilnehmer";
            cell.icon.image = [UIImage imageNamed:@"ic_participants.png"];
            return cell;
        }
        else if(indexPath.row==2)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Referenten";
            cell.icon.image = [UIImage imageNamed:@"ic_action_participants.png"];
            return cell;
        }
        else if(indexPath.row==3)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Austeller";
            cell.icon.image = [UIImage imageNamed:@"ic_star.png"];
            return cell;
        }
        else if(indexPath.row==4)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Kolloquium";
            cell.icon.image = [UIImage imageNamed:@"ic_launcher.png"];
            return cell;
        }
        else if(indexPath.row==5)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Wettbewerb";
            cell.icon.image = [UIImage imageNamed:@"ic_competition.png"];
            return cell;
        }
        else if(indexPath.row==6)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Finalists";
            cell.icon.image = [UIImage imageNamed:@"ic_finalists.png"];
            return cell;
        }
    }
    else if (indexPath.section==1){
        if(indexPath.row==0)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Veranstalter";
            cell.icon.image = [UIImage imageNamed:@"ic_institutes.png"];
            return cell;
        }
        else if(indexPath.row==1)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Partner";
            cell.icon.image = [UIImage imageNamed:@"ic_partners.png"];
            return cell;
        }
    }else if (indexPath.section ==2){
        if(indexPath.row==0)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Refresh data";
            cell.icon.image = [UIImage imageNamed:@"schedules.png"];
            return cell;
        }
        else if(indexPath.row==1)
        {
            static NSString *CellIdentifier = @"KQSideBarTableViewCell";
            KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.title.text=@"Logout";
            cell.icon.image = [UIImage imageNamed:@"ic_partners.png"];
            return cell;
        }
    }
        return nil;
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 43;
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"SectionHeader";
     KQSectionTableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    switch (section) {
        case 0:
            headerView.title.text = @"Event";
            break;
        case 1:
            headerView.title.text = @"Veranstalter";
            break;
        case 2:
            headerView.title.text = @"Algeimenes";
            break;
            
        default:
            break;
    }
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
        
        }
        else if(indexPath.row==4)
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"]];
            }
            else
            {
                [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"]];
                
            }
            
        }
        else if(indexPath.row==5)
        {
            
        }
        else if(indexPath.row==6)
        {
            
        }
    }
    else if (indexPath.section==1){
        if(indexPath.row==0)
        {
            
        }
        else if(indexPath.row==1)
        {
           
        }
    }else if (indexPath.section ==2){
        if(indexPath.row==0)
        {
            
        }
        else if(indexPath.row==1)
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:nil forKey:@"email"];
            [userDefaults synchronize];
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramViewController"]];
            
        }
    }
    
}

@end
