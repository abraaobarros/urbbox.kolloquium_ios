//
//  AboutViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 29/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AboutViewController.h"
#import "KQCache.h"
#import "KQEventAPI.h"
#import "Util.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
KQCache *cache;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    cache = [KQCache sharedManager];
    
    NSDictionary *data = [cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"];
    
    _kolloquium.text = [Util stripTags:[data objectForKey:@"descript"]];
    _date.text = [NSString stringWithFormat:@"%@ - %@", [data objectForKey:@"start"],[data objectForKey:@"finish"]];
    _address.text = [data objectForKey:@"address"];
    
    [_kolloquium sizeToFit];
    
    [KQEventAPI getImageFromUrl:[data objectForKey:@"thumb"] finishHandler:^(NSData* data){
        _photo.image=[UIImage imageWithData:data];
    } startHandler:^{
        
    } errorHandler:^{
    }];
    
    [Util setupNavigationBar:self withTitle:@"Das Kolloquium"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
