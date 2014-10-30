//
//  InstituteDepartamentDetailsViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 16/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface InstituteDepartamentDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *institute_en;
@property (weak, nonatomic) IBOutlet UILabel *responsable;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollInside;
@property (weak, nonatomic) IBOutlet UILabel *email;
@end
