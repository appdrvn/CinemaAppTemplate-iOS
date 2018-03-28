//
//  PreviewViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 15/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation PreviewViewController

- (void) layoutSetup
{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.selectedMovieModel.name length] > 0)
    {
        self.titleLabel.text = [NSString stringWithFormat:@"%@", self.selectedMovieModel.name];
    }
    else
    {
        self.titleLabel.text = @"";
    }
    
    if ([self.selectedMovieModel.synopsis length] > 0)
    {
        self.contentLabel.text = [NSString stringWithFormat:@"%@", self.selectedMovieModel.synopsis];
    }
    else
    {
        self.contentLabel.text = @"";
    }
    
    // Video
    self.webview.scalesPageToFit = NO;
    self.webview.delegate = self;
    self.webview.backgroundColor = [UIColor blackColor];
    self.webview.scrollView.scrollEnabled = NO;
    self.webview.opaque = NO;
    
    NSString *content = [NSString stringWithFormat:@"<iframe src=\"%@?rel=0&amp;showinfo=0\" width=\"%.f\" height=\"%.f\" style=\"border:none;overflow:hidden;\" scrolling=\"no\" frameborder=\"0\" allowtransparency=\"true\"></iframe>", self.selectedMovieModel.trailerUrl, [UIScreen mainScreen].bounds.size.width, CINEMA_VIEW_HEIGHT];
    
    NSString *htmlBody = [NSString stringWithFormat:@"<!DOCTYPE html><html>%@</html>", content];
    
    [self.webview loadHTMLString:htmlBody baseURL:nil];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    //    NSLog(@"Finished loading");
    webView.scrollView.maximumZoomScale = 1.0;
    webView.scrollView.minimumZoomScale = 1.0;
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    NSString *padding = @"document.body.style.margin='0';document.body.style.padding = '0'";
    [webView stringByEvaluatingJavaScriptFromString:padding];
}

#pragma mark - UIButtons Actions
- (IBAction)buyTicketPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(PreviewViewControllerDelegateDidClickOnBuyNow)])
    {
        [self.delegate PreviewViewControllerDelegateDidClickOnBuyNow];
    }
}

- (IBAction)moreInfoPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(PreviewViewControllerDelegateDidClickOnMoreInfo)])
    {
        [self.delegate PreviewViewControllerDelegateDidClickOnMoreInfo];
    }
}

@end
