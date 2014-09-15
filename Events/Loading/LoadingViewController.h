//
//  LoadingViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 25/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *pass;
- (IBAction)login_action:(id)sender;

- (IBAction)login_finish:(id)sender;
-(void) noInternetConnect;

@end
