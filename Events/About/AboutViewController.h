//
//  AboutViewController.h
//  Events
//
//  Created by Souvick Ghosh on 2/25/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ViewController.h"

@interface AboutViewController : ViewController
{
    UILabel *description;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewMain;
//@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *dates;
@property (weak, nonatomic) IBOutlet UIButton *ipt;
@property (weak, nonatomic) IBOutlet UIButton *wzl;

@end
