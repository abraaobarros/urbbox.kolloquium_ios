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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        static NSString *CellIdentifier = @"KQSideBarTableViewCell";
        KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.title.text=@"Schedule";
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
        cell.title.text=@"Speakers";
        cell.icon.image = [UIImage imageNamed:@"participants.png"];
        return cell;
    }
    else if(indexPath.row==2)
    {
        static NSString *CellIdentifier = @"KQSideBarTableViewCell";
        KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.title.text=@"About us";
        cell.icon.image = [UIImage imageNamed:@"About2.png"];
        return cell;
    }
    else if(indexPath.row==3)
    {
        static NSString *CellIdentifier = @"KQSideBarTableViewCell";
        KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.title.text=@"Institutes";
        cell.icon.image = [UIImage imageNamed:@"institutes.png"];
        return cell;
    }
    else if(indexPath.row==4)
    {
        static NSString *CellIdentifier = @"KQSideBarTableViewCell";
        KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.title.text=@"Exhibition";
        cell.icon.image = [UIImage imageNamed:@"About2.png"];
        return cell;
    }
    else if(indexPath.row==5)
    {
        static NSString *CellIdentifier = @"KQSideBarTableViewCell";
        KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.title.text=@"Refresh info";
        cell.icon.image = nil;
        return cell;
    }
//    else if(indexPath.row==3)
//    {
//        static NSString *CellIdentifier = @"KQSideBarTableViewCell";
//        KQSideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[KQSideBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        cell.title.text=@"Refresh Data";
//        cell.icon.image = [UIImage imageNamed:@"about.png"];
//        return cell;
//    }

    else
        return nil;
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 50;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    if(indexPath.row==1)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"]];        }
        else
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"]];

        }
    }
    if(indexPath.row==2)
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
    
}

@end
