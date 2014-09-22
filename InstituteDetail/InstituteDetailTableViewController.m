//
//  InstituteDetailTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 08/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "InstituteDetailTableViewController.h"
#import "InstituteDetailTableViewCell.h"
#import "KQEventAPI.h"
#import "ProgramDetailsViewController.h"
#import "UIViewController+JASidePanel.h"
#import "InstituteDepartamentDetailsViewController.h"

@interface InstituteDetailTableViewController (){
    NSMutableArray *dataSource;
}

@end

@implementation InstituteDetailTableViewController

KQEventAPI *event;
@synthesize tableView;

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
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [super viewDidLoad];
    
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.navigationItem.title = @"Werkzeugbau Mit Zukunft";
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    [self.navigationController setNavigationBarHidden:NO];
//    [self.view addSubview:myNav];
    
    event =[[KQEventAPI alloc]
            initWithDataAssyncWithStart:^(void){
                NSLog(@"Init Fetching");
                //                        [self performSegueWithIdentifier:@"LoadingViewController" sender:self];
            } finishProcess:^(void){
                NSLog(@"Finish Fetching");
                //                        [loading dismissViewControllerAnimated:YES completion:nil];
                [self loadDummyData];
            } errorHandler:^(void){
                //                        [loading dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Error Fetching");
            }];
    
    [self loadDummyData];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadDummyData{
    //dic initilization for dummy data start
    dataSource = [[[event objectForKey:@"organizers"] objectAtIndex:_index] objectForKey:@"departments"];
    NSLog(@"Lectures : %@",dataSource);
    [tableView reloadData];
    //dic initilization for dummy data end
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InstituteDetailTableViewCell";
    InstituteDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[InstituteDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //    cell.imgEventImage.image=[UIImage imageNamed:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    cell.title.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.subtitle.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name_en"];
    
    //    cell.imgEventImage.image = [UIImage imageNamed:@"no_profile.png"];
    cell.image.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"thumb"]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.image.image=[UIImage imageWithData: data];
            });
        }@catch (NSException *exception) {
            NSLog(@"Error : %@",exception);
        }
        
    });
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // Get reference to the destination view controller
        InstituteDepartamentDetailsViewController *vc = (InstituteDepartamentDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InstituteDepartamentDetailsViewController"];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        [self.sidePanelController setRightPanel:vc];
        [self.sidePanelController showRightPanelAnimated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:@"InstituteDepartamentDetailsViewController" sender:self];
    }
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
