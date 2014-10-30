//
//  PdfViewController.m
//  Events
//
//  Created by Razu on 27.10.14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "PdfViewController.h"

@interface PdfViewController ()

@end

@implementation PdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *URL = [NSURL URLWithString:_pdfUrl];
    if (_pdfUrl != (id)[NSNull null]) {
        [_webView loadRequest:[NSURLRequest requestWithURL:URL]];
    }else{
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_loading startAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_loading stopAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [_loading stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closePdfButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
