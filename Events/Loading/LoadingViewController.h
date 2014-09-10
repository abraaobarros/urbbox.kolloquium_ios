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

-(void) noInternetConnect;
-(void) dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;

@end
