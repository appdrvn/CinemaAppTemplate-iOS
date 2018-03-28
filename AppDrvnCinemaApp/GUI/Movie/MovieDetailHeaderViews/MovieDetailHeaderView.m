//
//  MovieDetailHeaderView.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/25/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieDetailHeaderView.h"
#import "AppConstants.h"

@interface MovieDetailHeaderView()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MovieDetailHeaderView

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (id)initWithFrame:(CGRect)rect
{
    if (self = [super initWithFrame:rect])
    {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        [self addSubview:self.view];
        
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
    }
    return self;
}

- (void) updateDisplay:(NSString *)trailerUrl
{
    self.webView.scalesPageToFit = NO;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor blackColor];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.opaque = NO;
    
    NSString *content = [NSString stringWithFormat:@"<iframe src=\"%@?rel=0&amp;showinfo=0\" width=\"%.f\" height=\"%.f\" style=\"border:none;overflow:hidden;\" scrolling=\"no\" frameborder=\"0\" allowtransparency=\"true\"></iframe>", trailerUrl, [UIScreen mainScreen].bounds.size.width, CINEMA_VIEW_HEIGHT];
    
    NSString *htmlBody = [NSString stringWithFormat:@"<!DOCTYPE html><html>%@</html>", content];
    
    [self.webView loadHTMLString:htmlBody baseURL:nil];
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


@end
