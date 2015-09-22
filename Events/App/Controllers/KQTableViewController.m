//
//  KQTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "KQTableViewController.h"
#import "UIViewController+JASidePanel.h"
#import "Util.h"
#import "LayoutCell.h"


@interface KQTableViewController ()

@end

@implementation KQTableViewController
NSArray *datasource;
Layout *layout;

- (void)viewDidLoad {


    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    layout = [[self delegate] tableViewLayout];
    datasource = [layout datasource];
    
    [Util setupNavigationBar:self withTitle:[layout navigationTitle]];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [datasource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:[layout cellIdentifier]  forIndexPath:indexPath];
    [cell setData:[datasource objectAtIndex:indexPath.row]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [layout cellHeight];

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


}

@end
