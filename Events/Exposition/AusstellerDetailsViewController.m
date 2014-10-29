//
//  ExibitorsDetailsViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AusstellerDetailsViewController.h"
#import "TeilnehmerTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "KQEventAPI.h"

@interface AusstellerDetailsViewController ()

@end

@implementation AusstellerDetailsViewController

@synthesize data;

NSArray *dataSource;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setData:(NSDictionary *)d
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if ([d objectForKey:@"background"]==(id)[NSNull null] || [data objectForKey:@"background"] == nil) {
        _finalists.hidden=YES;
        _tableView.hidden = NO;
        dataSource = [d objectForKey:@"participants"];
        _institute_en.text = [d objectForKey:@"name"];
        _des.text = [d objectForKey:@"short_descript"];
        _mobile.text = [d objectForKey:@"responsible_tel"];
        _email.text = [d objectForKey:@"responsible_email"];
        if ([data objectForKey:@"localization"]==(id)[NSNull null] || [d objectForKey:@"localization"] == nil) {
            
        }else{
            _stand.text = [NSString stringWithFormat:@"%@",[d objectForKey:@"localization"]];
            _tableView.hidden = YES;
        }
        [_des sizeToFit];
        
        
    }else{
        _finalists.hidden=NO;
        _tableView.hidden = YES;
        _institute_en.text = [d objectForKey:@"name"];
        _strenghts.text = [d objectForKey:@"strengths"];
        _des.text =[d objectForKey:@"profile"];
        [_strenghts sizeToFit];
        
        _background.text = [d objectForKey:@"background"];
        [_background sizeToFit];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            NSData *data_img = [NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"logo"]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                _photo.image=[UIImage imageWithData: data_img];
            });
        }@catch (NSException *exception) {
            NSLog(@"Error : %@",exception);
        }
        
    });
    
    [self.tableView reloadData];
    
    [_scrollView setContentSize:_viewParent.frame.size];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setData:data];
    [self.tableView reloadData];
    
        // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setData:data];
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ParticipantsTableCell";
    TeilnehmerTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[TeilnehmerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[dataSource objectAtIndex: indexPath.row] objectForKey:@"name"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
                [mailViewController setSubject:@"Subject Goes Here."];
                [mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"email"], nil];
        [mailViewController setToRecipients:toRecipients];
        mailViewController.mailComposeDelegate =self;
        [self presentViewController:mailViewController animated:YES completion:^{
            
        }];
    } else {
        NSLog(@"Device is unable to send email in its current state.");
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
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

@end
