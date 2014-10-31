//
//  InfoViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 27/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoDetailTableViewController.h"
#import "Util.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Util setupNavigationBar:self withTitle:@"Aachen"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 321;
    }else{
        return 184;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"InfoDetailTableViewController" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    InfoDetailTableViewController *vc = (InfoDetailTableViewController *) [segue destinationViewController];
    switch (self.tableView.indexPathForSelectedRow.row) {
        case 0:
            [vc setKinddd:@"touristc_points"];
            break;
        case 1:
            [vc setKinddd:@"restaurants" ];
            break;
        case 2:
            [vc setKinddd:@"hotels" ];
            break;
        default:
            break;
    }
}

@end
