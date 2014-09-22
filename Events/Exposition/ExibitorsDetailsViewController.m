//
//  ExibitorsDetailsViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ExibitorsDetailsViewController.h"
#import "ParticipantsTableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface ExibitorsDetailsViewController ()

@end

@implementation ExibitorsDetailsViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",data);
    
    dataSource = [data objectForKey:@"participants"];
    _institute_en.text = [data objectForKey:@"name"];
    _description.text = [data objectForKey:@"short_descript"];
    _mobile.text = [data objectForKey:@"responsible_tel"];
    _email.text = [data objectForKey:@"responsible_email"];
    _stand.text = [NSString stringWithFormat:@"Find me in stand: %@",[data objectForKey:@"localization"]];
    [_description sizeToFit];
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
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
    NSLog(@"%@",data);
    
    dataSource = [data objectForKey:@"participants"];
    _institute_en.text = [data objectForKey:@"name"];
    _description.text = [data objectForKey:@"short_descript"];
    _mobile.text = [data objectForKey:@"responsible_tel"];
    _email.text = [data objectForKey:@"responsible_email"];
    _stand.text = [NSString stringWithFormat:@"Find me in stand: %@",[data objectForKey:@"localization"]];
    [_description sizeToFit];
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
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ParticipantsTableCell";
    ParticipantsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ParticipantsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.name.text = [[dataSource objectAtIndex: indexPath.row] objectForKey:@"name"];
    //    cell.imgEventImage.image=[UIImage imageNamed:[[dataSource objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    //    cell.title.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name"];
    //    cell.subtitle.text=[[dataSource objectAtIndex:indexPath.row] valueForKey:@"name_en"];
    
    //    cell.imgEventImage.image = [UIImage imageNamed:@"no_profile.png"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        //        [mailViewController setSubject:@"Subject Goes Here."];
        //        [mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:[[dataSource objectAtIndex:indexPath.row] objectForKey:@"email"], nil];
        [mailViewController setToRecipients:toRecipients];
        mailViewController.mailComposeDelegate =self;
        [self presentModalViewController:mailViewController animated:YES];
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
    [self dismissModalViewControllerAnimated:YES];
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
