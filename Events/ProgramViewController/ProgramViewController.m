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
    NSArray *data;
   
}

@end

@implementation ProgramViewController
KQEventAPI *event;
@synthesize tableView;
BOOL reload = FALSE;

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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"email"]) {
        [self performSegueWithIdentifier:@"LoadingViewController" sender:self];
    }
    event =[[KQEventAPI alloc]
                    initWithDataAssyncWithStart:^(void){
                        [self performSegueWithIdentifier:@"Loading2ViewController" sender:self];
                    } finishProcess:^(void){
                        NSLog(@"Finish Fetching");
                        [self loadDummyData];
                    } errorHandler:^(void){
                        [self performSegueWithIdentifier:@"LoadingViewController" sender:self];
                    }];
    
    [self loadDummyData];
    
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    [Util setupNavigationBar:self withTitle:@"Das Programm"];
    
    CGRect frame= _segmentDay.frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [_segmentDay setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 60)];
    }
    else
    {
        [_segmentDay setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 45)];
    }
    
    UIFont *font = [UIFont boldSystemFontOfSize:18.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [_segmentDay setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];

}
            

- (IBAction)reloadData:(id)sender {
    [event reloadData:^(void){
        } startHandler:^{
            [self performSegueWithIdentifier:@"LoadingViewController" sender:self];
            [self loadDummyData];
        } errorHandler:^{
            [loading dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"Error Fetching");
        }];
}

-(void) reload{
    reload = FALSE;
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
        [dateFormater setDateFormat:@"dd/MM/yyyy HH:mm"];
        
        NSDate *d1 = [dateFormater dateFromString:[first objectForKey:@"date"]];
        NSDate *d2 = [dateFormater dateFromString:[second objectForKey:@"date"]];
        
        return [d1 compare:d2];
        
    }];
    data = [[NSMutableArray alloc] initWithArray:retorno];
    dataImageSource = [[NSMutableDictionary alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"date BEGINSWITH[c] %@", @"04/11/2014"];
    dataSource  = [data filteredArrayUsingPredicate:predicate];
    [_segmentDay setSelectedSegmentIndex:0];
    
    
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
    cell.lblDateTime.text=[self convertDataFormat:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"date"] withPattern:@"dd/MM/yyyy HH:mm" toPattern:@"HH:mm - "];
    cell.lblEventName.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"subject"];
    cell.lblEventDesc.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"descript"];
    
    //[cell.lblEventName sizeToFit];
    [cell.lblEventDesc sizeToFit];
    cell.data.text=[Util convertDataFormat:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"date"] withPattern:@"dd/MM/yyyy HH:mm" toPattern:@"dd MMM"];
    @try {
        cell.speaker.text = [[[dataSource objectAtIndex:indexPath.row] valueForKey:@"speaker"] objectForKey:@"name"];
        cell.company.text=[[[dataSource objectAtIndex:indexPath.row] valueForKey:@"speaker"] objectForKey:@"company"];
    }
    @catch (NSException *exception) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            cell.speaker.text = [NSString stringWithFormat:@"Ort: %@",[[dataSource objectAtIndex:indexPath.row] valueForKey:@"location"]];
        } else {
            cell.speaker.text = @"";
        }
        
        cell.company.text = @"";
    }
    @finally {
        
    }
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {
        cell.location.text = [NSString stringWithFormat:@"%@",[[dataSource objectAtIndex:indexPath.row] valueForKey:@"location"]];
    }else{
        cell.location.text = @"";
    }
    
    
    cell.imgEventImage.image = nil;
    
    [KQEventAPI getImageFromUrl:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"thumb"] finishHandler:^(NSData* d){
        cell.imgEventImage.image=[UIImage imageWithData:d];
    } startHandler:^{
        NSLog(@"Init Image loader");
    
    } errorHandler:^{
        NSLog(@"Problem Image loader");
    }];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        // Get reference to the destination view controller
        ProgramDetailsViewController *vc = (ProgramDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramDetailsViewController"];
        NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
        vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
        [vc setData:data];
    
    if ([data objectForKey:@"speaker_id"]!=(id)[NSNull null]) {
        [self.sidePanelController setRightPanel:vc];
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
        {
                [self.sidePanelController setRightFixedWidth:self.view.frame.size.width*6/7];
        }else{
            if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
            {
                [self.sidePanelController setRightFixedWidth:650];
            }else{
            }
        }
        [self.sidePanelController showRightPanelAnimated:YES];
    }
    
    
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

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"LoadingViewController"])
    {
        // Get reference to the destination view controller
        loading = [segue destinationViewController];
        [loading setLoadingMode:NO];

        
        // Pass any objects to the view controller here, like...
    }
    if ([[segue identifier] isEqualToString:@"Loading2ViewController"])
    {
        // Get reference to the destination view controller
        loading = [segue destinationViewController];
        @try {
            [loading setLoadingMode:YES];
        }
        @catch (NSException *exception) {
        }
        
        
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
}

- (IBAction)segmentDayChange:(id)sender {
    if (_segmentDay.selectedSegmentIndex==0) {
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"date BEGINSWITH[c] %@", @"04/11/2014"];
        dataSource = [[data filteredArrayUsingPredicate:predicate] mutableCopy];
        
    }else{
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"date BEGINSWITH[c] %@", @"05/11/2014"];
        dataSource = [[data filteredArrayUsingPredicate:predicate] mutableCopy];
        
    }
    [tableView reloadData];
}



- (IBAction)leftBar:(id)sender {
    [self.sidePanelController setCenterPanelHidden:YES];
}
@end
