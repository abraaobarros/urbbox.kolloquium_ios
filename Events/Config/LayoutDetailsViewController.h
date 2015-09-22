//
//  LayoutDetailsViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Layout.h"
#import "HCSStarRatingView.h"

IB_DESIGNABLE

@interface LayoutDetailsViewController : UITableViewController
@property (nonatomic) IBInspectable NSString *text;


@property (nonatomic, strong) Layout *layout;

@property (weak, nonatomic) IBOutlet UITableViewCell *ratingTableCell;

@end
