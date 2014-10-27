//
//  PdfViewController.h
//  Events
//
//  Created by Razu on 27.10.14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)closePdfButton:(id)sender;
@property (weak, nonatomic) NSString *pdfUrl;
@end
