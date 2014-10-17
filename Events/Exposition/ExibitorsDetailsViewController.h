//
//  ExibitorsDetailsViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 22/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExibitorsDetailsViewController : UIViewController
@property (strong, nonatomic) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *institute_en;
@property (weak, nonatomic) IBOutlet UILabel *responsable;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *stand;
@property (weak, nonatomic) IBOutlet UILabel *description;

@property (weak, nonatomic) IBOutlet UIView *finalists;
@property (weak, nonatomic) IBOutlet UILabel *background;
@property (weak, nonatomic) IBOutlet UILabel *strenghts;
@end
