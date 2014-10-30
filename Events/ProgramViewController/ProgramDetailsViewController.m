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
#import "PdfViewController.h"
#import "CustomIOS7AlertView.h"
#import "UIPlaceHolderTextView.h"

@interface ProgramDetailsViewController ()

@end

@implementation ProgramDetailsViewController
@synthesize name;
@synthesize subject;
@synthesize data;
@synthesize location;

UIDocumentInteractionController *documentInteractionController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (IBAction)openPDF:(id)sender {
    
    [self performSegueWithIdentifier:@"PdfViewController" sender:self];
    
}
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

- (void)viewDidLoad
{

    @try {
        name.text = [data objectForKey:@"subject"];
        _descript.text = [Util stripTags:[data objectForKey:@"descript"]];
        [_descript sizeToFit];
        subject.text = [[data objectForKey:@"speaker"] objectForKey:@"name"];
        if([[[data objectForKey:@"speaker"] objectForKey:@"name"] isEqualToString:@"Information"]){
            _company.text = @"";
        }else{
            _company.text = [[data objectForKey:@"speaker"]objectForKey:@"company"];
        }
        if ([data objectForKey:@"location"] != (id)[NSNull null]) {
            location.text = [NSString stringWithFormat:@"Pullman Quellenhof, %@.%@ um %@ Uhr",
                             [Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"dd/MM/yyy HH:mm" toPattern:@"dd"] ,
                             [Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"dd/MM/yyy HH:mm" toPattern:@"MMM"],
                             [Util convertDataFormat:[data valueForKey:@"date"] withPattern:@"dd/MM/yyy HH:mm" toPattern:@"HH:mm"]];
        }
        _photo.image=[UIImage imageNamed:@"no_profile.png"];
        [KQEventAPI getImageFromUrl:[[data objectForKey:@"speaker"] objectForKey:@"profile_img"]
                       finishHandler:^(NSData *_data) {
                           _photo.image=[UIImage imageWithData: _data];
                       }
                        startHandler:^{
                            
                        } errorHandler:^{
                            
                        }];
        
        if ([data objectForKey:@"document"]==(id)[NSNull null] || [data objectForKey:@"document"]== nil) {
            _pdfButton.hidden=YES;
            CGRect f = _quetion.frame;
            _quetion.frame = f;
            f.origin.x = 238;
            f.origin.y = 69;
        }else{
            CGRect f = _quetion.frame;
            f.origin.x = 61;
            f.origin.y = 141;
            if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
            {
                
                _quetion.frame = f;
            }
            
            _pdfButton.hidden=NO;
        }
        [_scroll setContentSize:_contentView.frame.size];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

//    [subject sizeToFit];
    [_descript sizeToFit];
    [_scrollView setContentSize:_descript.viewForBaselineLayout.frame.size];
    [_company sizeToFit];
//    [name sizeToFit];
    [_quetion resignFirstResponder];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendQuestion:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [KQEventAPI makeQuestion:_quetion.text
                  toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                      message:@"Frage gesendet"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil];
                      [alert show];
                      [_quetion resignFirstResponder];
                 } startHandler:^{
                     NSLog(@"Começou");
                 } errorHandler:^{
                     NSLog(@"Deu Errado");
                 }];
}

- (IBAction)changeQuestion:(id)sender {
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Stellen Sie eine Frage" message:@"lhre Frage wird von dem Referent empfangen" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    
//    [alert setTag:1];
//    [alert show];
    
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    textView.editable = YES;
    textView.clipsToBounds = YES;
    textView.layer.cornerRadius = 10.0f;
    [textView setPlaceholder:@"Stellen Sie eine Frage"];
    [alertView setContainerView:textView];
    [alertView setTag:0];
    [alertView setDelegate:self];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Ok", nil]];
    [alertView show];
    
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if([alertView tag] == 0 && buttonIndex == 1){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc] init];
        textView = (UIPlaceHolderTextView *)[alertView containerView];
        [KQEventAPI makeQuestion:textView.text
                      toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                          message:@"Frage gesendet"
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
    if([alertView tag] == 1 && buttonIndex == 1){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc] init];
        textView = (UIPlaceHolderTextView *)[alertView containerView];
        [KQEventAPI makeReview:textView.text
                     withScore:(int)_avaliacao.selectedSegmentIndex toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                         message:@"Bewertung gesendet"
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
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}


- (IBAction)changeAvaliation:(id)sender {
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Bewertung schreiben" message:@"Sagen Sie uns lhre Meinung" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alert setTag:2];
//    [alert show];
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    textView.editable = YES;
    textView.clipsToBounds = YES;
    textView.layer.cornerRadius = 10.0f;
    [textView setPlaceholder:@"Sagen Sie uns lhre Meinung"];
    [alertView setContainerView:textView];
    [alertView setDelegate:self];
    [alertView setTag:1];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Ok", nil]];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (alertView.tag == 2 && buttonIndex==1) {
        [KQEventAPI makeReview:[[alertView textFieldAtIndex:0] text]
                     withScore:(int)_avaliacao.selectedSegmentIndex toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                         message:@"Bewertung gesendet"
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
    if (alertView.tag == 1 && buttonIndex==1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [KQEventAPI makeQuestion:[[alertView textFieldAtIndex:0] text]
                      toActivity:[[data objectForKey:@"id"] intValue] withParticipant:[[userDefaults objectForKey:@"id"] intValue] finishHandler:^{
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gesendet"
                                                                          message:@"Frage gesendet"
                                                                         delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil];
                          [alert show];
                      } startHandler:^{
                          NSLog(@"Começou");
                      } errorHandler:^{
                          NSLog(@"Deu Errado");
                      }];    }
    

    
    
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
}


-(void)setData:(NSDictionary *)new_data{
    @try {
        _photo.image=[UIImage imageNamed:@"no_profile.png"];
        data = new_data;
        name.text = [new_data objectForKey:@"subject"];
        _descript.text = [Util stripTags:[new_data objectForKey:@"descript"]];
        subject.text = [[new_data objectForKey:@"speaker"] objectForKey:@"name"];
        if ([data objectForKey:@"location"] != (id)[NSNull null]) {
            location.text = [NSString stringWithFormat:@"Pullman Quellenhof, %@.%@ um %@ Uhr",
                             [Util convertDataFormat:[new_data valueForKey:@"date"] withPattern:@"dd/MM/yyy HH:mm" toPattern:@"dd"] ,
                             [Util convertDataFormat:[new_data valueForKey:@"date"] withPattern:@"dd/MM/yyy HH:mm" toPattern:@"MMM"],
                            [Util convertDataFormat:[new_data valueForKey:@"date"] withPattern:@"dd/MM/yyy HH:mm" toPattern:@"HH:mm"]];
        }
        if ([data objectForKey:@"document"]==(id)[NSNull null] || [data objectForKey:@"document"]== nil) {
            _pdfButton.hidden=YES;
        }else{
            _pdfButton.hidden=NO;
        }
        if([[[data objectForKey:@"speaker"] objectForKey:@"name"] isEqualToString:@"Information"]){
            _company.text = @"";
        }else{
            _company.text = [[data objectForKey:@"speaker"]objectForKey:@"company"];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                NSData *data_img = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[new_data objectForKey:@"speaker"] objectForKey:@"profile_img"]]];
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
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"PdfViewController"]){
        PdfViewController *vc = (PdfViewController *)[segue destinationViewController];
        vc.pdfUrl = [data objectForKey:@"document"];

    }
}

@end
