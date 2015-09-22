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
                    } errorHandler:^(void){
                        [self performSegueWithIdentifier:@"Loading2ViewController" sender:self];
                    
                    
                    }];

    
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    [Util setupNavigationBar:self withTitle:@"Das Programm"];
    
    [self loadData];
    
    

}

-(void) styleSegmentDay{
    
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
            [self loadData];
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
-(void)loadData{
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
    dataSource  = [[data filteredArrayUsingPredicate:predicate] mutableCopy];
    [_segmentDay setSelectedSegmentIndex:0];
    [Util setupNavigationBar:self withTitle:@"Das Programm"];
    
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
    [cell setData:[dataSource objectAtIndex:indexPath.row]];
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
    
    
    if ([[dataSource objectAtIndex:indexPath.row] objectForKey:@"speaker_id"]!=(id)[NSNull null]) {
    
        [self performSegueWithIdentifier:@"ProgramDetailsViewController" sender:self];
    
    }
    
    
}
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"ProgramDetailsViewController"])
    {
        ProgramDetailsViewController *viewController = (ProgramDetailsViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        viewController.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:indexPath.row]];

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

-(BOOL)shouldAutorotate{
    return NO;
}

- (IBAction)leftBar:(id)sender {
    [self.sidePanelController setCenterPanelHidden:YES];
}
@end
