//
//  InstituteDepartamentDetailsViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 16/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "InstituteDepartamentDetailsViewController.h"
#import "InstituteDepartamentDetailTableViewCell.h"
#import "KQEventAPI.h"

@interface InstituteDepartamentDetailsViewController ()

@end

@implementation InstituteDepartamentDetailsViewController
@synthesize data;
NSArray *dataSource;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",data);
    
    dataSource = [data objectForKey:@"services"];
    _institute_en.text = [data objectForKey:@"name"];
    _responsable.text = [data objectForKey:@"responsible_name"];
    _mobile.text = [data objectForKey:@"responsible_tel"];
    _email.text = [data objectForKey:@"responsible_email"];
    [KQEventAPI getImageFromUrl:[data objectForKey:@"thumb"] finishHandler:^(NSData* _data){
        _photo.image=[UIImage imageWithData:_data];
    } startHandler:^{
        
    } errorHandler:^{
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            NSData *data_img = [NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"thumb"]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                _photo.image=[UIImage imageWithData: data_img];
            });
        }@catch (NSException *exception) {
            NSLog(@"Error : %@",exception);
        }
        
    });
    // Do any additional setup after loading the view.
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
    static NSString *CellIdentifier = @"InstituteDepartamentDetailTableViewCell";
    InstituteDepartamentDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[InstituteDepartamentDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.service.text = [[dataSource objectAtIndex: indexPath.row] objectForKey:@"name"];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
