//
//  KQTableViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "LayoutSetup.h"
#import "Layout.h"

@protocol KQTableViewControllerProtocoll <NSObject>

-(Layout *) tableViewLayout;

@end

@interface KQTableViewController : UITableViewController

@property (retain) id delegate;

@end
