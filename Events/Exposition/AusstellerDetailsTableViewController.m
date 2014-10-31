//
//  AusstellerDetailsTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 29/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AusstellerDetailsTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KQEventAPI.h"

@interface AusstellerDetailsTableViewController (){

    MPMoviePlayerViewController *movie;

}


@end

@implementation AusstellerDetailsTableViewController
@synthesize data;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",data);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _institute_en.text = [data objectForKey:@"name"];
    NSString *htmlString = @"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"background:#fff;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"172\"><param name=\"movie\" value=\"http://www.youtube.com/v/2RF3QoCnPfU&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/2RF3QoCnPfU&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"172\"></embed></object></div></body></html>";
    
    
    [_institute_en sizeToFit];
    if ([data objectForKey:@"short_descript"]==nil || [data objectForKey:@"short_descript"]==(id)[NSNull null]) {
        _des.text =[data objectForKey:@"profile"];
        _background.text = [data objectForKey:@"background"];
        _finalists.hidden = NO;
        _finalists.text = @"Ausgewählte Stärken";
        _strenghts.text = [data objectForKey:@"strengths"];
        _type = 0;
        [_videoWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.your-url.com"]];
        
    }else{
        _type = 1;
        _strenghts.text = [data objectForKey:@"location"];
        _des.text =[data objectForKey:@"short_descript"];
        _finalists.text = @"Teilnehmer";
        _background_name.hidden = YES;
        _strenghts.text = @"";
        
        @try {
            if([[data objectForKey:@"participants"] count]==0){
                _finalists.hidden = YES;
            }
            for (NSDictionary *d in [data objectForKey:@"participants"]) {
                _strenghts.text = [NSString stringWithFormat:@"%@%@\n\n",_strenghts.text,[d objectForKey:@"name" ]];
            }
        }
        @catch (NSException *exception) {
            _finalists.hidden = YES;
        }
        
        
    }
    [_strenghts sizeToFit];
    [_des sizeToFit];
    [_background sizeToFit];
    [KQEventAPI getImageFromUrl:[data objectForKey:@"logo"] finishHandler:^(NSData *d) {
        _photo.image=[UIImage imageWithData: d];
    } startHandler:^{
        
    } errorHandler:^{
        
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            NSData *data_img = [NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"logo"]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                _photo.image=[UIImage imageWithData: data_img];
                _photo.contentMode = UIViewContentModeScaleAspectFit;
            });
        }@catch (NSException *exception) {
            NSLog(@"Error : %@",exception);
        }
        
    });
}
-(void)setData:(NSDictionary *)d{
    _institute_en.text = [data objectForKey:@"name"];
    [_institute_en sizeToFit];
    
    data =d;
    if ([data objectForKey:@"short_descript"]==nil || [data objectForKey:@"short_descript"]==(id)[NSNull null]) {
        _des.text =[data objectForKey:@"profile"];
        _background.text = [data objectForKey:@"background"];
        _finalists.hidden = NO;
        _finalists.text = @"Ausgewählte Stärken";
        _strenghts.text = [data objectForKey:@"strengths"];
        _type = 0;
        _videoWebView.hidden = NO;
        NSString *videoID = [self getVideoIdFromURL:[data objectForKey:@"video"]];
        NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"background:#fff;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"172\"><param name=\"movie\" value=\"http://www.youtube.com/v/%@&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/%@&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"172\"></embed></object></div></body></html>",videoID,videoID];
        [_videoWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.your-url.com"]];
        
    }else{
        _type = 1;
        _strenghts.text = [data objectForKey:@"location"];
        _des.text =[data objectForKey:@"short_descript"];
        _finalists.text = @"Teilnehmer";
        _background_name.hidden = YES;
        _strenghts.text = @"";
        _videoWebView.hidden = YES;
        @try {
            if([[data objectForKey:@"participants"] count]==0){
                _finalists.hidden = YES;
            }else{
                _finalists.hidden = NO;
            }
            for (NSDictionary *d in [data objectForKey:@"participants"]) {
                _strenghts.text = [NSString stringWithFormat:@"%@%@\n\n",_strenghts.text,[d objectForKey:@"name" ]];
            }
        }
        @catch (NSException *exception) {
            _finalists.hidden = YES;
        }
        
        
    }
    [_strenghts sizeToFit];
    [_des sizeToFit];
    [_background sizeToFit];
    //    }
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

- (NSString *)getVideoIdFromURL:(NSString *) videoUrl{
    NSError *error = NULL;
    NSString *pattern = @"(?:(?:\.be\/|embed\/|v\/|\\?v=|\&v=|\/videos\/)|(?:[\\w+]+#\\w\/\\w(?:\/[\\w]+)?\/\\w\/))([\\w-_]+)";

    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern: pattern
                                                                            options: NSRegularExpressionCaseInsensitive
                                                                              error: &error];
    NSTextCheckingResult *match = [regex firstMatchInString: videoUrl
                                                    options: 0
                                                      range: NSMakeRange(0, [videoUrl length])];
    if ( match ) {
        NSRange videoIDRange             = [match rangeAtIndex:1];
        NSString *substringForFirstMatch = [videoUrl substringWithRange:videoIDRange];
        
        NSLog(@"url: %@, Youtube ID: %@", videoUrl, substringForFirstMatch);
        return videoUrl;
    } else {
        NSLog(@"No string matched! %@", videoUrl);
        return  nil;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        switch (indexPath.row) {
        case 0:
            return 220;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return _institute_en.frame.size.height+10;
            break;
        case 3:
            return _des.frame.size.height+10;
            break;
        case 4:
            return _strenghts.frame.size.height+50;
            break;
        case 5:
            return _background.frame.size.height+50;
            break;
        default:
            return 172;
            break;
        }
    }else{
            switch (indexPath.row) {
                case 0:
                    return 120;
                    break;
                case 1:
                    return 30;
                    break;
                case 2:
                    return _institute_en.frame.size.height+10;
                    break;
                case 3:
                    return _des.frame.size.height+10;
                    break;
                case 4:
                    return _strenghts.frame.size.height+50;
                    break;
                case 5:
                    return _background.frame.size.height+50;
                    break;
                default:
                    return 172;
                    break;
            }
        }

    return 100;
    

}
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(BOOL)shouldAutorotate{
    return NO;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    
//    // Configure the cell...
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
