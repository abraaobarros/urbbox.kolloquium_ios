//
//  AusstellerDetailsTableViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 29/10/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AusstellerDetailsTableViewController : UITableViewController

@property(nonatomic,weak) NSDictionary *data;
@property(nonatomic,weak) NSArray *dataSource;
@property(nonatomic) NSInteger type;
@property (weak, nonatomic) IBOutlet UIView *viewParent;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *institute_en;
@property (weak, nonatomic) IBOutlet UILabel *responsable;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *stand;
@property (weak, nonatomic) IBOutlet UILabel *finalists;
@property (weak, nonatomic) IBOutlet UILabel *background;
@property (weak, nonatomic) IBOutlet UILabel *strenghts;
@property (weak, nonatomic) IBOutlet UILabel *background_name;
@property (weak, nonatomic) IBOutlet UILabel *teilneh;
@end
