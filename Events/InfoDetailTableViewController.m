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
NSString* kinddd;

NSArray * dataSource;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    cache = [KQCache sharedManager];
    
    NSDictionary *data = [cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"];
    
    dataSource =[[data objectForKey:@"information"] objectForKey:kinddd];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:155.0/255.0 green:0.0 blue:32.0/255.0 alpha:1];
    
}
-(void)setKinddd:(NSString *)kind{
    kinddd = [[NSString alloc] initWithString:kind];
    kinddd = kind;
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


@end
