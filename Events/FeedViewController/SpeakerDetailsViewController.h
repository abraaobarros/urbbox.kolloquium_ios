//
//  SpeakerDetailsViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 25/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakerDetailsViewController : UIViewController

@property (strong, nonatomic) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *profission;
@property (weak, nonatomic) IBOutlet UILabel *conferences;
@property (weak, nonatomic) IBOutlet UILabel *email_label;
@property (weak, nonatomic) IBOutlet UIButton *mobile;
@property (weak, nonatomic) IBOutlet UILabel *about;
@property (weak, nonatomic) IBOutlet UIButton *email;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mobile_tel;
@end
