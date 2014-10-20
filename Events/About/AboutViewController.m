//
//  AboutViewController.m
//  Events
//
//  Created by Souvick Ghosh on 2/25/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutCustomCell1.h"
#import "AboutCustomCell2.h"
#import "AboutCustomCell3.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "KQEventAPI.h"
#import "Util.h"
#import "ProgramDetailsViewController.h"
#import "InstituteDetailTableViewController.h"
@interface AboutViewController ()

@end

@implementation AboutViewController
KQEventAPI *event;
NSInteger *_index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)wzl_button:(id)sender {
    // Get reference to the destination view controller
    _index=1;
    [self performSegueWithIdentifier:@"Institiute" sender:self];
}
- (IBAction)ipt_button:(id)sender {
    _index=0;
    [self performSegueWithIdentifier:@"Institiute" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollViewMain.contentSize = CGSizeMake(self.scrollViewMain.frame.size.width,
                                          320);

    
    
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    [Util setupNavigationBar:self withTitle:@"Kolloquium"];
    
    event =[[KQEventAPI alloc]
            initWithDataAssyncWithStart:^(void){
                NSLog(@"Init Fetching");
            } finishProcess:^(void){
                _description.text = [event objectForKey:@"descript"];
                _address.text =[event objectForKey:@"address"];
                _dates.text = [NSString stringWithFormat:@"%@  -  %@",[event objectForKey:@"start"],[event objectForKey:@"finish"]];
                [_description sizeToFit];

            } errorHandler:^(void){
                NSLog(@"Error Fetching");
            }];
    
    self.scrollViewMain.delegate = (id)self;
    [self initializeNavigationBar];
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initializeNavigationBar{
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark - Button Clicked
-(IBAction)clickedShare:(id)sender{
    NSArray *activityItems = nil;
    UIImage *appIcon = [UIImage imageNamed:@"Direction.png"];
    NSString *postText = [[NSString alloc] initWithFormat:@"Temp String"];
    activityItems = @[postText,appIcon];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];

}
-(IBAction)clickedSendTo:(id)sender{
    NSArray *activityItems = nil;
    UIImage *appIcon = [UIImage imageNamed:@"Direction.png"];
    NSString *postText = [[NSString alloc] initWithFormat:@"Temp String"];
    activityItems = @[postText,appIcon];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];

}
#pragma mark -Table Delegate
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
    static NSString *CellIdentifier = @"AboutCustomCell1";
    AboutCustomCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AboutCustomCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        cell.lblEventAddress.text=@"Aachen. Eurogress,7 Germany";
        cell.lblEventDistance.text=@"13.5km";
        cell.lblEventName.text=@"Kolloquim";
    return cell;
    }
    else if(indexPath.row==1)
    {
        static NSString *CellIdentifier = @"AboutCustomCell2";
        AboutCustomCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AboutCustomCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.lblDateTime.text=@"18/10/2014 12 PM";
        return cell;
    }
    else if(indexPath.row==2)
    {
        static NSString *CellIdentifier = @"AboutCustomCell3";
        AboutCustomCell3 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AboutCustomCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        return cell;
    }
    else
        return nil;
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    switch (indexPath.row) {
        case 0:
            return 55;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 44;
            break;
        default:
            return 44;
            break;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0)
    {
        
    }
    
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"Institiute"])
    {
        // Get reference to the destination view controller
        InstituteDetailTableViewController *vc = (InstituteDetailTableViewController *)[segue destinationViewController];
        vc.index=_index;
        // Pass any objects to the view controller here, like...
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
