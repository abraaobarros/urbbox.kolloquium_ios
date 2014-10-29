//
//  SpeakerDetailsViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 25/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "SpeakerDetailsViewController.h"
#import "KQEventAPI.h"
#import "Util.h"

@interface SpeakerDetailsViewController ()

@end

@implementation SpeakerDetailsViewController
@synthesize data;

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
    _profission.text = [data objectForKey:@"company"];
    _name.text = [data objectForKey:@"name"];
    _email_label.text = [data objectForKey:@"email"];
    _mobile_tel.text = [data objectForKey:@"tel"];
    _about.text = [Util stripTags: [data objectForKey:@"about"]];
    [_about sizeToFit];
    [KQEventAPI getImageFromUrl:[data objectForKey:@"profile_img"]
                  finishHandler:^(NSData *dataImage) {
                      _image.image = [UIImage imageWithData: dataImage];
                  }
                   startHandler:^{
                       
                   } errorHandler:^{
                       
                   }];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    _profission.text = [data objectForKey:@"company"];
    _name.text = [data objectForKey:@"name"];
    _email_label.text = [data objectForKey:@"email"];
    _mobile_tel.text = [data objectForKey:@"tel"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mobile_click:(id)sender {
}
- (IBAction)email_click:(id)sender {
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

@end
