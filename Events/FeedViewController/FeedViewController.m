//
//  FeedViewController.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCustomCell.h"
#import "SecondFeedCustomCell.h"
#import "ThirdFeedCustomCell.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@interface FeedViewController ()
{
    // NSMutableArray *arrFeedImages;
    NSMutableArray *dicTweetFeed;
    NSMutableArray *dicImageFeed;

}

@end

@implementation FeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self dicDummyDataInitialization];
    self.navigationItem.leftBarButtonItem = self.sidePanelController.leftButtonForCenterPanel;
    //arrFeedImages=[[NSMutableArray alloc] initWithObjects:@"pic.png",@"image1.png",@"image2.png", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)dicDummyDataInitialization{
    //dic initilization for dummy data start
    dicTweetFeed = [[NSMutableArray alloc] init];
    NSDictionary *tweetFeedItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"pic.png",@"Prof. Christian Brecher",@"IPT",@"https://twitter.com/BCCI",@"This fashion show will beautiful, I will present what do you think?",@"9013",@"https://twitter.com/BCCI", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"userName",@"userId",@"userLink",@"tweet",@"comments",@"commentsLink", nil]];
    [dicTweetFeed addObject:tweetFeedItem];
    
    tweetFeedItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"pic.png",@"Prof. Christian Brecher",@"IPT",@"https://twitter.com/BCCI",@"This fashion show will beautiful, I will present what do you think?",@"9013",@"https://twitter.com/BCCI", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"userName",@"userId",@"userLink",@"tweet",@"comments",@"commentsLink", nil]];
    [dicTweetFeed addObject:tweetFeedItem];
    
    tweetFeedItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"pic.png",@"Prof. Christian Brecher",@"IPT",@"https://twitter.com/BCCI",@"This fashion show will beautiful, I will present what do you think?",@"9013",@"https://twitter.com/BCCI", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"userName",@"userId",@"userLink",@"tweet",@"comments",@"commentsLink", nil]];
    [dicTweetFeed addObject:tweetFeedItem];
    
    tweetFeedItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"pic.png",@"Prof. Christian Brecher",@"IPT",@"https://twitter.com/BCCI",@"This fashion show will beautiful, I will present what do you think?",@"9013",@"https://twitter.com/BCCI", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"userName",@"userId",@"userLink",@"tweet",@"comments",@"commentsLink", nil]];
    [dicTweetFeed addObject:tweetFeedItem];
    tweetFeedItem = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"pic.png",@"Prof. Christian Brecher",@"IPT",@"https://twitter.com/BCCI",@"This fashion show will beautiful, I will present what do you think?",@"9013",@"https://twitter.com/BCCI", nil] forKeys:[[NSArray alloc] initWithObjects:@"image",@"userName",@"userId",@"userLink",@"tweet",@"comments",@"commentsLink", nil]];
    [dicTweetFeed addObject:tweetFeedItem];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    return 4; //[arrFeedImages count];
    
    
    return dicTweetFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row%2==0) {
        static NSString *CellIdentifier = @"";
        if((indexPath.row)%2==0)
        {
            CellIdentifier = @"FeedCustomCell";
        }
        else
        {
            CellIdentifier = @"ThirdFeedCustomCell";
        }
        
        FeedCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell)
        {
            cell = [[FeedCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.imgMainImage.image=[UIImage imageNamed:[[dicTweetFeed objectAtIndex:indexPath.row/2] valueForKey:@"image"]];
        cell.lblTweet.text=[[dicTweetFeed objectAtIndex:indexPath.row/2] valueForKey:@"tweet"];
        cell.lblUserName.text=[[dicTweetFeed objectAtIndex:indexPath.row/2] valueForKey:@"userName"];
        cell.btnUserId.titleLabel.text=[[dicTweetFeed objectAtIndex:indexPath.row/2] valueForKey:@"userId"];
        
        cell.lblViewComment.text=[NSString stringWithFormat:@"View other %@ comments",[[dicTweetFeed objectAtIndex:indexPath.row/2] valueForKey:@"comments"]];
        
        return cell;

//    }else if (indexPath.row%2!=0){
//        static NSString *CellIdentifier = @"SecondFeedCustomCell";
//        SecondFeedCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        if(!cell)
//        {
//            cell = [[SecondFeedCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        if(dicImageFeed.count>=0+(indexPath.row/2)*3)
//           [cell.btnOne setImage:[UIImage imageNamed:[[dicImageFeed objectAtIndex:indexPath.row/2*3] valueForKey:@"image"]] forState:UIControlStateNormal];
//        if(dicImageFeed.count>=1+(indexPath.row/2)*3)
//            [cell.btnTwo setImage:[UIImage imageNamed:[[dicImageFeed objectAtIndex:1+(indexPath.row/2)*3] valueForKey:@"image"]] forState:UIControlStateNormal];
//        if(dicImageFeed.count>=2+(indexPath.row/2)*3)
//            [cell.btnThree setImage:[UIImage imageNamed:[[dicImageFeed objectAtIndex:2+(indexPath.row/2)*3] valueForKey:@"image"]] forState:UIControlStateNormal];
//        
//        return cell;
//        
//    }
//    return Nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
