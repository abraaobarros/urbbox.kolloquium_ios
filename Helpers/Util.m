//
//  Util.m
//  Events
//
//  Created by Abraao Barros Lacerda on 10/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "Util.h"
#import "UIViewController+JASidePanel.h"

@implementation Util


+(NSString *) convertDataFormat:(NSString *) data withPattern:(NSString *) from toPattern:(NSString *) to;{
    NSString *str =data; /// here this is your date with format yyyy-MM-dd
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:from]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:to];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    return convertedString;
}

+(void) setupNavigationBar:(UIViewController *)viewController withTitle:(NSString *) title{
    
//    viewController.navigationItem.title = @"Werkzeugbau Mit Zukunft";
    viewController.navigationItem.title = title;
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName,[UIColor colorWithRed:155.0/255.0 green:0.0 blue:32.0/255.0 alpha:1],NSForegroundColorAttributeName, nil];
    viewController.navigationController.navigationBar.titleTextAttributes = size;

    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:155.0/255.0 green:0.0 blue:32.0/255.0 alpha:1];


}

@end
