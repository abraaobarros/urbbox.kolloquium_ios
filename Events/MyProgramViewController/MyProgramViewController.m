//
//  MyProgramViewController.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "MyProgramViewController.h"
#import "MyProgramCustomCell.h"
#import "ProgramCustomCell.h"
#import "VRGCalendarView.h"
#import "EventCalCell.h"
@interface MyProgramViewController () 
{
    NSMutableArray *arrMyProgram;//for my tickets
    NSMutableArray *dicProgramDescription;//for my favorites
    NSMutableArray *arrMyCalEvents;//for event calendar eventlist
    
    int segmentPosition;//0 or 1 or 2 to check which segment is selected
    UIView *calendarBG;
    
}
@end

@implementation MyProgramViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [ initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializewithDummyData];
    segmentPosition=2;
    self.btnNotifiction.titleLabel.text=[NSString stringWithFormat:@"%d",[arrMyProgram count]];
    
    
    //self.scrollViewerTableContainer.contentSize = CGSizeMake(self.scrollViewerTableContainer.frame.size.width,320);
    //self.scrollViewerTableContainer.delegate = (id)self;
    //_arrDetails=[[NSMutableArray alloc] initWithObjects:@"Gate Code Name",@"2909 Clearview Dr. austin Tx 78703",@"(512)750-9628",@"(512)391-1648",@"Not Available",@"mgershon@glowfirm.com", nil];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initializewithDummyData
{
    arrMyProgram = [[NSMutableArray alloc] init];
    NSDictionary *myProgramItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Milan Fashion Week",@"12/23/13 6:00PM-10:00PM",@"Free", nil] forKeys:[[NSArray alloc] initWithObjects:@"programName",@"programDateTime",@"status", nil]];
    [arrMyProgram addObject:myProgramItem];
    myProgramItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"2013 Music Award",@"12/23/13 6:00PM",@"Free", nil] forKeys:[[NSArray alloc] initWithObjects:@"programName",@"programDateTime",@"status", nil]];
    [arrMyProgram addObject:myProgramItem];
    myProgramItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"NY Startup Weekend",@"12/23/13 6:00PM-10:00PM",@" ", nil] forKeys:[[NSArray alloc] initWithObjects:@"programName",@"programDateTime",@"status", nil]];
    [arrMyProgram addObject:myProgramItem];
    myProgramItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Milan Fashion Week",@"12/23/13 10:00PM",@"Free", nil] forKeys:[[NSArray alloc] initWithObjects:@"programName",@"programDateTime",@"status", nil]];
    [arrMyProgram addObject:myProgramItem];
 
    
    
        dicProgramDescription = [[NSMutableArray alloc] init];
        NSDictionary *eventLocation = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Livello1.png",@"Tomorrow 12:00AM",@"Gautier Runway show",@"The first runway show for the revered designer", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"header",@"desc", nil]];
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
    switch (segmentPosition) {
        case 0:
            return [arrMyCalEvents count];
            break;
        case 1:
            return [dicProgramDescription count];
            break;
        case 2:
            return [arrMyProgram count];
            break;
        default:
            return 0;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(segmentPosition==2)
    {
        static NSString *CellIdentifier = @"MyProgramCustomCell";
        MyProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (!cell) {
            cell=[[MyProgramCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.lblDateTime.text=[[arrMyProgram objectAtIndex:indexPath.row] valueForKey:@"programDateTime"];
        cell.lblProgramName.text=[[arrMyProgram objectAtIndex:indexPath.row] valueForKey:@"programName"];
        cell.lblStatus.text=[[arrMyProgram objectAtIndex:indexPath.row] valueForKey:@"status"];
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:17]};
        CGSize stringsize = [cell.lblDateTime.text sizeWithAttributes:attributes];
        //CGSize maximumLabelSize = CGSizeMake(296,9999);
        //CGSize stringsize =[cell.lblDateTime.text sizeWithFont:cell.lblDateTime.font
                           //constrainedToSize:maximumLabelSize
                              // lineBreakMode:cell.lblDateTime.lineBreakMode];
        [cell.lblDateTime setFrame:CGRectMake(cell.lblDateTime.frame.origin.x,cell.lblDateTime.frame.origin.y,stringsize.width, 21)];
        [cell.lblStatus setFrame:CGRectMake(stringsize.width+5,cell.lblStatus.frame.origin.y,cell.lblStatus.frame.size.width, cell.lblStatus.frame.size.height)];
        
        
        return cell;
    }
    else if(segmentPosition==1)
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
    else if(segmentPosition==0)
    {
        static NSString *CellIdentifier = @"EventCalCell";
        EventCalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell)
        {
            cell = [[EventCalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        cell.lblDateTime.text=[[arrMyCalEvents objectAtIndex:indexPath.row] valueForKey:@"date"];
        cell.lblEventName.text=[[arrMyCalEvents objectAtIndex:indexPath.row] valueForKey:@"eve_name"];
        cell.lblEventPlace.text=[[arrMyCalEvents objectAtIndex:indexPath.row] valueForKey:@"place"];
        cell.imgStatusIcon.image=[UIImage imageNamed:[[arrMyCalEvents objectAtIndex:indexPath.row] valueForKey:@"image"]];
        
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:11]};
        CGSize stringsize = [cell.lblEventPlace.text sizeWithAttributes:attributes];
        [cell.lblEventPlace setFrame:CGRectMake(cell.lblEventPlace.frame.origin.x,cell.lblEventPlace.frame.origin.y,stringsize.width, 21)];
        [cell.imgPlaceIcon setFrame:CGRectMake(cell.lblEventPlace.frame.origin.x+cell.lblEventPlace.frame.size.width,cell.imgPlaceIcon.frame.origin.y,cell.imgPlaceIcon.frame.size.width, cell.imgPlaceIcon.frame.size.height)];

        
        
        
        return cell;
    }
    else
        return NULL;
    
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    switch (segmentPosition) {
        case 0:
            return 44;
            break;
        case 1:
            return 162;
            break;
        case 2:
            return 56;
            break;
        default:
            return 0;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark - Button Clicked Function

- (IBAction)clickedNotifictionBtn:(id)sender {
}

- (IBAction)clickedMyTickets:(id)sender {
    [self.scrollViewMain setContentSize:CGSizeMake(0, 0)];
    [calendarBG removeFromSuperview];
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y=0;
    if (IS_IPHONE_5)
        rect.size.height=423;
    else
        rect.size.height=323;
    self.tblMainTable.frame=rect;
    segmentPosition=2;
    [self.btnMyTickets setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented.png"];
    [self.tblMainTable reloadData];
    self.btnNotifiction.titleLabel.text=[NSString stringWithFormat:@"%d",arrMyProgram.count];
    
}

- (IBAction)clickedMyFavourites:(id)sender {
    [self.scrollViewMain setContentSize:CGSizeMake(0, 0)];
    [calendarBG removeFromSuperview];
    segmentPosition=1;
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y=0;
    if(IS_IPHONE_5)
        rect.size.height=423;
    else
        rect.size.height=323;
    self.tblMainTable.frame=rect;
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_middle.png"];
    [self.tblMainTable reloadData];
    self.btnNotifiction.titleLabel.text=[NSString stringWithFormat:@"%d",dicProgramDescription.count];
}

- (IBAction)clickedMyCalender:(id)sender {
    segmentPosition=0;
    
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_left.png"];
    self.btnNotifiction.titleLabel.text=@"";
    [self createCalendarView];
    [self.tblMainTable reloadData];
    
}
#pragma mark - Calendar Functions
-(void)createCalendarView{
    
        CGRect rect=self.tblMainTable.frame;
        rect.size.height=300;
        calendarBG=[[UIView alloc] initWithFrame:rect];
        VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
        calendar.delegate=(id)self;
        [calendarBG addSubview:calendar];
        [self.scrollViewMain addSubview:calendarBG];
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y=targetHeight;
    rect.size.height=200;
    self.tblMainTable.frame=rect;
    [self.scrollViewMain setContentSize:CGSizeMake(320, targetHeight+rect.size.height)];
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
   // NSLog(@"Selected date = %@",date);
    arrMyCalEvents = [[NSMutableArray alloc] init];
    NSDictionary *eventCalItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"GreenDot.png",@"12:00AM",@"Gautier Runway show",@"Milan", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"eve_name",@"place", nil]];
    [arrMyCalEvents addObject:eventCalItem];
    eventCalItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"GreenDot.png",@"12/13/14",@"Onething Conference 2013",@"India", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"eve_name",@"place", nil]];
    [arrMyCalEvents addObject:eventCalItem];
    eventCalItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"RedDot.png",@"12:00AM",@"Gautier Runway show",@"NY", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"date",@"eve_name",@"place", nil]];
    [arrMyCalEvents addObject:eventCalItem];
    //dic initilization for dummy data end
    [self.tblMainTable reloadData];


    
}


@end
