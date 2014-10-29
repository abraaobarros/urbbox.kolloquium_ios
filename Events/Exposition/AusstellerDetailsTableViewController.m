//
//  AusstellerDetailsTableViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 29/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AusstellerDetailsTableViewController.h"

@interface AusstellerDetailsTableViewController ()


@end

@implementation AusstellerDetailsTableViewController
@synthesize data;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",data);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_institute_en sizeToFit];
    
    if ([data objectForKey:@"short_descript"]==nil || [data objectForKey:@"short_descript"]==(id)[NSNull null]) {
        _des.text =[data objectForKey:@"profile"];
        _background.text = [data objectForKey:@"background"];
        _finalists.hidden = NO;
        _finalists.text = @"Ausgewählte Stärken";
        _strenghts.text = [data objectForKey:@"strengths"];
        _type = 0;
        
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
-(void)setData:(NSDictionary *)d{
    [_institute_en sizeToFit];
    
    data =d;
    if ([data objectForKey:@"short_descript"]==nil || [data objectForKey:@"short_descript"]==(id)[NSNull null]) {
        _des.text =[data objectForKey:@"profile"];
        _background.text = [data objectForKey:@"background"];
        _finalists.hidden = NO;
        _finalists.text = @"Ausgewählte Stärken";
        _strenghts.text = [data objectForKey:@"strengths"];
        _type = 0;
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            return 100;
            break;
    }
    return 100;
    

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
