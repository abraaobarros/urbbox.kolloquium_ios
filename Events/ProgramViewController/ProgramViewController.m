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
#import "ProgramDetailsViewController.h"
#import "KQEventAPI.h"
#import "Util.h"
#import "LoadingViewController.h"
@interface ProgramViewController (){
    
    NSMutableArray *dicProgramDescription;
    NSMutableArray *dataSource;
    NSMutableDictionary *dataImageSource;
    LoadingViewController *loading;
}

@end

@implementation ProgramViewController
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
    NSLog(@"Program");
    event =[[KQEventAPI alloc]
                    initWithDataAssyncWithStart:^(void){
                        NSLog(@"Init Fetching");
                        [self performSegueWithIdentifier:@"LoadingViewController" sender:self];
                    } finishProcess:^(void){
                        NSLog(@"Finish Fetching");
//                        [loading dismissViewControllerAnimated:YES completion:nil];
                        [self loadDummyData];
                    } errorHandler:^(void){
//                        [loading dismissViewControllerAnimated:YES completion:nil];
                        NSLog(@"Error Fetching");
                    }];
    
    [self loadDummyData];
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];

}
            

- (IBAction)reloadData:(id)sender {
    [event reloadData:^(void){
            //[self performSegueWithIdentifier:@"LoadingViewController" sender:self];
        } startHandler:^{
            [loading dismissViewControllerAnimated:YES completion:nil];
            [self loadDummyData];
        } errorHandler:^{
            [loading dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"Error Fetching");
        }];
}
            
            

-(void)openLeftNavigation{
    NSLog(@"aqui");
    [self.sidePanelController showLeftPanelAnimated:YES];
}
-(void)loadDummyData{
    //dic initilization for dummy data start
    NSArray *retorno = [event objectForKey:@"activities"];
    self.navigationItem.title = [event objectForKey:@"name"];
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    retorno = [retorno sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDictionary *first =(NSDictionary*)a;
        NSDictionary *second = (NSDictionary*)b;
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *d1 = [dateFormater dateFromString:[first objectForKey:@"date"]];
        NSDate *d2 = [dateFormater dateFromString:[second objectForKey:@"date"]];
        
        return [d1 compare:d2];
        
    }];
    dataSource = [[NSMutableArray alloc] initWithArray:retorno];
    dataImageSource = [[NSMutableDictionary alloc] init];
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
    return [dataSource count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        return 235;
    }
    else
    {
        return 163;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgramCustomCell";
    ProgramCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    cell.imgEventImage.image=[UIImage imageNamed:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    cell.lblDateTime.text=[self convertDataFormat:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"date"] withPattern:@"yyyy-MM-dd HH:mm:ss" toPattern:@"HH:mm"];
    cell.lblEventName.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"subject"];
    cell.lblEventDesc.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"descript"];
    [cell.lblEventName sizeToFit];
    
    cell.data.text=[Util convertDataFormat:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"date"] withPattern:@"yyyy-MM-dd HH:mm:ss" toPattern:@"dd MMM"];
    
    cell.speaker.text = [[[dataSource objectAtIndex:indexPath.row] valueForKey:@"speaker"] objectForKey:@"name"];
    
    
    
    
    cell.imgEventImage.image = nil;
    
    [event getImageFromUrl:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"thumb"] finishHandler:^(NSData* data){
        cell.imgEventImage.image=[UIImage imageWithData:data];
    
    } startHandler:^{
        NSLog(@"Init Image loader");
    
    } errorHandler:^{
        NSLog(@"Problem Image loader");
    }];

//    if ([dataImageSource objectForKey:[dataSource objectAtIndex:indexPath.row]]) {
//        cell.imgEventImage.image=[UIImage imageWithData: [dataImageSource objectForKey:[dataSource objectAtIndex:indexPath.row]]];
//    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            @try {
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"thumb"]]];
//                dispatch_sync(dispatch_get_main_queue(), ^{
//                    cell.imgEventImage.image=[UIImage imageWithData: data];
//                    [dataImageSource setObject:data forKey:[dataSource objectAtIndex:indexPath.row]];
//                });
//            }@catch (NSException *exception) {
//                NSLog(@"Error : %@",exception);
//            }
//            
//        });
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        // Get reference to the destination view controller
        ProgramDetailsViewController *vc = (ProgramDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramDetailsViewController"];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        [self.sidePanelController setRightPanel:vc];
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {

        [self.sidePanelController setRightFixedWidth:300];
    }
        [self.sidePanelController showRightPanelAnimated:YES];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"ProgramDetailsViewController" sender:self];
//    }
}


-(NSString *) convertDataFormat:(NSString *) data withPattern:(NSString *) from toPattern:(NSString *) to{
    NSString *str =data; /// here this is your date with format yyyy-MM-dd

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:from]; //// here set format of date which is in your output date (means above str with format)

    NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format

    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:to];// here set format which you want...

    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    return convertedString;
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

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"LoadingViewController"])
    {
        // Get reference to the destination view controller
        loading = [segue destinationViewController];

        
        // Pass any objects to the view controller here, like...
    }
    if ([[segue identifier] isEqualToString:@"ProgramDetailsViewController"])
    {
        // Get reference to the destination view controller
        ProgramDetailsViewController *vc = (ProgramDetailsViewController *)[segue destinationViewController];
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
        // Pass any objects to the view controller here, like...
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




- (IBAction)leftBar:(id)sender {
    [self.sidePanelController setCenterPanelHidden:YES];
}
@end
