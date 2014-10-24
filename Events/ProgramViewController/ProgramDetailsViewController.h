//
//  ProgramDetailsViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 20/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramDetailsViewController : UIViewController<UIDocumentInteractionControllerDelegate>{
}

-(void) setContent:(NSDictionary *) data;
@property (strong, nonatomic) IBOutlet UILabel *subject;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *descript;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UISegmentedControl *avaliacao;
@property (strong, nonatomic) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UITextField *quetion;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
