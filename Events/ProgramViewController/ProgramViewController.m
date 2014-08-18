//
//  ProgramViewController.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ProgramViewController.h"
#import "ProgramCustomCell.h"
#import "UIViewController+JASidePanel.h"
@interface ProgramViewController (){
    
    NSMutableArray *dicProgramDescription;

}

@end

@implementation ProgramViewController

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
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    [super viewDidLoad];
    [self loadDummyData];
    
    

//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
//    self.navigationController.navigationBar.appearance = [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bd_navigation"] forBarMetrics:UIBarMetricsDefault];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)openLeftNavigation{
    NSLog(@"aqui");
    [self.sidePanelController showLeftPanelAnimated:YES];
    

}
-(void)loadDummyData{
    //dic initilization for dummy data start
    dicProgramDescription = [[NSMutableArray alloc] init];
    NSDictionary *eventLocation = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Livello1.png",@"Tomorrow 12:00AM",@"Industry 4.0",@"Oportunities for medium-sized engineering industry", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"header",@"desc", nil]];
    [dicProgramDescription addObject:eventLocation];
    eventLocation = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Livello2.png",@"Today 12:00AM",@"Onething Conference 2013",@"Kansas Ciity Convention Center", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"header",@"desc", nil]];
    [dicProgramDescription addObject:eventLocation];
    eventLocation = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Livello3.png",@"Today 12:00AM",@"Gautier Runway show",@"The first runway show for the revered designer", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"header",@"desc", nil]];
    [dicProgramDescription addObject:eventLocation];
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
     return [dicProgramDescription count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgramCustomCell";
    ProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.imgEventImage.image=[UIImage imageNamed:[[dicProgramDescription objectAtIndex:indexPath.row] valueForKey:@"image"]];
    cell.lblDateTime.text=[[dicProgramDescription objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.lblEventName.text=[[dicProgramDescription objectAtIndex:indexPath.row] valueForKey:@"header"];
    cell.lblEventDesc.text=[[dicProgramDescription objectAtIndex:indexPath.row] valueForKey:@"desc"];
    
    // Configure the cell...
    
    return cell;
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

- (IBAction)leftBar:(id)sender {
    [self.sidePanelController setCenterPanelHidden:YES];
}
@end
