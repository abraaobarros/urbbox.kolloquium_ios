//
//  InfoDetailTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 31/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "InfoDetailTableViewController.h"
#import "Util.h"
#import "KQCache.h"
#import "ProgramCustomCell.h"
#import "KQEventAPI.h"

@interface InfoDetailTableViewController ()

@end

@implementation InfoDetailTableViewController
KQCache * cache;
NSArray * dataSource;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    cache = [KQCache sharedManager];
    
    NSDictionary *data = [cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"];
    
    dataSource =[[data objectForKey:@"information"] objectForKey:@"restaurants"];
    
    
}

- (void)didReceiveMemoryWarning {
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
    cell.lblEventName.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"address"];
    cell.lblEventDesc.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"address"];
    cell.company.text = [[dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];
    //[cell.lblEventName sizeToFit];
    [cell.lblEventDesc sizeToFit];
    
    
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
