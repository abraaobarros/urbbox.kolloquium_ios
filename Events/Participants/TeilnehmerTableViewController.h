//
//  ParticipantsTableViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 19/09/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface TeilnehmerTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate,UISearchDisplayDelegate,MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSArray *filteredArray;
@property (strong,nonatomic) NSArray *dataSource;
@end
