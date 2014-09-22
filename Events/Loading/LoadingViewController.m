//
//  LoadingViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 25/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "LoadingViewController.h"
#import "KQEventAPI.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"email"]) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }    }
    return self;
}

- (void)viewDidLoad
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"email"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"email"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void) setLoadingMode:(BOOL)mode{
    _login_view.hidden =mode;

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

- (IBAction)login_action:(id)sender {
    [_pass resignFirstResponder];
    [_login resignFirstResponder];
    [KQEventAPI makeLogin:_login.text withPass:_pass.text
            finishHandler:^{
                _textLoading.hidden = NO;
                _textLoading.text = @"Getting information...";
                KQEventAPI *event = [[KQEventAPI alloc] initWithDataAssyncWithStart:^{
                } finishProcess:^{
                    [_loading stopAnimating];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } errorHandler:^{
                    _textLoading.hidden = NO;
                    _textLoading.text = @"No internet connection";
                }];
            } startHandler:^{
                [_loading startAnimating];
                _textLoading.hidden = NO;
                _textLoading.text = @"Logging in...";
            } errorHandler:^{
                _textLoading.hidden = NO;
                _textLoading.text = @"No internet connection, try again later";
                [_loading stopAnimating];
            } loginErrorHandler:^{
                _textLoading.hidden = NO;
                _textLoading.text = @"Wrong password or username";
                [_loading stopAnimating];
            }];
}

- (IBAction)login_finish:(id)sender {
}
@end
