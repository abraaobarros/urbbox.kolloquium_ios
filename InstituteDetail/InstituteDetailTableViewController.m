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
#import "Util.h"

@interface InstituteDetailTableViewController (){
}

@end

@implementation InstituteDetailTableViewController

KQEventAPI *event;
@synthesize tableView,dataSource;

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
    

    
    
    
    [self loadData];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadData{
    //dic initilization for dummy data start
    if ([self.title isEqual:@"WZL"]) {
        dataSource = [[[event objectForKey:@"organizers"] objectAtIndex:1] objectForKey:@"departments"];
        [Util setupNavigationBar:self withTitle:[[[event objectForKey:@"organizers"] objectAtIndex:1] objectForKey:@"name"]];
    }else if ([self.title isEqual:@"IPT"]) {
        dataSource = [[[event objectForKey:@"organizers"] objectAtIndex:0] objectForKey:@"departments"];
        [Util setupNavigationBar:self withTitle:[[[event objectForKey:@"organizers"] objectAtIndex:0] objectForKey:@"name"]];
    }else if ([self.title isEqual:@"Aachen"]) {
        dataSource = [[[event objectForKey:@"organizers"] objectAtIndex:0] objectForKey:@"departments"];
        [Util setupNavigationBar:self withTitle:[[[event objectForKey:@"organizers"] objectAtIndex:0] objectForKey:@"name"]];
    }
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
    
    [KQEventAPI getImageFromUrl:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"thumb"] finishHandler:^(NSData* data){
        cell.image.image=[UIImage imageWithData:data];
    } startHandler:^{
        
    } errorHandler:^{
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        return 265;
    }
    else
    {
        return 182;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InstituteDepartamentDetailsViewController *vc = (InstituteDepartamentDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InstituteDepartamentDetailsViewController"];
    
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    NSLog(@"IP: %@",[dataSource objectAtIndex:ip.row]);
    vc.data =[[NSDictionary alloc] initWithDictionary:[dataSource objectAtIndex:ip.row]];
    [self.sidePanelController setRightFixedWidth:self.view.frame.size.width*9/10];
    [self.sidePanelController setMaximumAnimationDuration:0.5];
    [self.sidePanelController setRightPanel:vc];
    [self.sidePanelController showRightPanelAnimated:YES];

}


@end



