//
//  ProgramDetailsViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 20/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ProgramDetailsViewController.h"
#import "Util.h"
#import "KQEventAPI.h"

@interface ProgramDetailsViewController ()

@end

@implementation ProgramDetailsViewController
@synthesize name;
@synthesize description;
@synthesize subject;
@synthesize data;
@synthesize location;

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

    @try {
        name.text = [data objectForKey:@"subject"];
        description.text = [data objectForKey:@"descrition"];
        subject.text = [[data objectForKey:@"speaker"] objectForKey:@"name"];
        if ([data objectForKey:@"location"] != (id)[NSNull null]) {
            location.text = [NSString stringWithFormat:@"In the Eurogress, at %@ at %@ of %@",
                             [Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"yyyy-MM-dd HH:mm:ss" toPattern:@"HH:mm"],[Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"yyyy-MM-dd HH:mm:ss" toPattern:@"dd"],[Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"yyyy-MM-dd HH:mm:ss" toPattern:@"MMM"]];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                NSData *data_img = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[data objectForKey:@"speaker"] objectForKey:@"profile_img"]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    _photo.image=[UIImage imageWithData: data_img];
                });
            }@catch (NSException *exception) {
                NSLog(@"Error : %@",exception);
            }
            
        });
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

//    [subject sizeToFit];
    [description sizeToFit];
//    [name sizeToFit];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setContent:(NSDictionary *) data{
    name.text = @"muito bom";
    description.text = @"muito bom";
    subject.text = @"muito bom";
}
- (IBAction)sendQuestion:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [KQEventAPI makeQuestion:_quetion.text
                  toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                      message:@"Dein Frage war gesendet"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil];
                      [alert show];
                 } startHandler:^{
                     NSLog(@"Começou");
                 } errorHandler:^{
                     NSLog(@"Deu Errado");
                 }];
}
- (IBAction)send:(id)sender {
     NSLog(@"Aqui");
}
- (IBAction)changeAvaliation:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Bewertung Schreiben" message:@"Sagen Sie uns lhre Meinung" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [KQEventAPI makeReview:[[alertView textFieldAtIndex:0] text]
                 withScore:(int)_avaliacao.selectedSegmentIndex toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                     message:@"Dein Bewertung war gesendet"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                 } startHandler:^{
                     NSLog(@"Começou");
                 } errorHandler:^{
                     NSLog(@"Deu Errado");
                 }];
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
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
