//
//  LoadingViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 25/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "Loading2ViewController.h"
#import "KQEventAPI.h"

@interface Loading2ViewController ()

@end

@implementation Loading2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [[KQEventAPI alloc]
     initWithDataAssyncWithStart:^(void){
     } finishProcess:^(void){
         [self dismissViewControllerAnimated:YES completion:nil];
     } errorHandler:^(void){
        _loading_label.text = @"No internet connection";
         [_loading stopAnimating];
        _try.hidden=NO;
     }];
}

- (IBAction)try_again:(id)sender {
    [[KQEventAPI alloc]
     initWithDataAssyncWithStart:^(void){
         _try.hidden=YES;
         [_loading startAnimating];
         _loading_label.text = @"Loading data...";
     } finishProcess:^(void){
         [self dismissViewControllerAnimated:YES completion:nil];
     } errorHandler:^(void){
         _loading_label.text = @"No internet connection";
         [_loading stopAnimating];
         _try.hidden=NO;
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)login_finish:(id)sender {
}
@end
