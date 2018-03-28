//
//  CustomPullToRefresh.m
//  PullToRefreshDemo
//
//  Created by John Wu on 3/22/12.
//  Copyright (c) 2012 TFM. All rights reserved.
//

#import "CustomPullToRefresh.h"

#define PULL_TO_REFRESH @"Pull To Refresh"
#define LOAD_MORE @"Load More"
#define RELEASE_TO_LOAD @"Release to load"
#define LOADING @"Loading..."

@implementation CustomPullToRefresh

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id<CustomPullToRefreshDelegate>)delegate
{
    self = [super init];
    
    if (self)
    {
        _delegate = delegate;
        _scrollView = scrollView;
        [_scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        
        _pullToRefreshController = [[MSPullToRefreshController alloc] initWithScrollView:_scrollView delegate:self];
        
        CGFloat minusSpace;
        minusSpace = 11;
        
        _activityViewTop = [[UIActivityIndicatorView alloc] init];
        _activityViewTop.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - minusSpace, - 55, 22, 22);
        _activityViewTop.backgroundColor = [UIColor clearColor];
        _activityViewTop.color = [UIColor darkGrayColor];
        [scrollView addSubview:_activityViewTop];
        
        _labelBot = [[UILabel alloc] init];
        _labelBot.text = LOAD_MORE;
        _labelBot.textColor = [UIColor lightGrayColor];
        _labelBot.font = [UIFont systemFontOfSize:11];
        _labelBot.textAlignment = NSTextAlignmentCenter;
        _labelBot.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _labelBot.frame = CGRectMake(0, _scrollView.frame.size.height + 20, 100, 15);
        [scrollView addSubview:_labelBot];
        
        _activityViewBot = [[UIActivityIndicatorView alloc] init];
        _activityViewBot.frame = CGRectMake(0, _scrollView.frame.size.height + 20, 12, 12);
        _activityViewBot.color = [UIColor darkGrayColor];
        [scrollView addSubview:_activityViewBot];
        
        _labelTop = [[UILabel alloc] init];
        _labelTop.text = PULL_TO_REFRESH;
        _labelTop.textColor = [UIColor lightGrayColor];
        _labelTop.font = [UIFont systemFontOfSize:11];
        _labelTop.textAlignment = NSTextAlignmentCenter;
        _labelTop.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 50, -25, 100, 15);
        [scrollView addSubview:_labelTop];
    }
    
    return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGFloat contentSizeArea = _scrollView.contentSize.width*_scrollView.contentSize.height;
    CGFloat frameArea = _scrollView.frame.size.width*_scrollView.frame.size.height;
    CGSize adjustedContentSize = contentSizeArea < frameArea ? _scrollView.frame.size : _scrollView.contentSize;
    
    _rainbowBot.frame = CGRectMake(0, adjustedContentSize.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
    _labelBot.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width / 2) - 50, adjustedContentSize.height + 20, 100, 14);
    _activityViewBot.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width / 2) - 50, adjustedContentSize.height + 20, 12, 12);
}

- (void) dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void) endRefresh
{
    [_pullToRefreshController finishRefreshingDirection:MSRefreshDirectionTop animated:YES];
    
    _activityViewTop.hidden = YES;
    [_activityViewTop stopAnimating];
    
    _activityViewTop.hidden = NO;
    [_activityViewTop startAnimating];
    _labelTop.text = PULL_TO_REFRESH;
    
    [_pullToRefreshController finishRefreshingDirection:MSRefreshDirectionBottom animated:YES];
    [_rainbowBot stopAnimating];
    _arrowBot.hidden = NO;
    _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
    _labelBot.hidden = YES;
    _activityViewBot.hidden = YES;
    [_activityViewBot stopAnimating];
}

- (void) startRefresh
{
    [_pullToRefreshController startRefreshingDirection:MSRefreshDirectionTop];
}

#pragma mark - MSPullToRefreshDelegate Methods

- (BOOL) pullToRefreshController:(MSPullToRefreshController *)controller canRefreshInDirection:(MSRefreshDirection)direction
{
    return direction == MSRefreshDirectionTop;
}

- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction
{
    return 68 + 65;
}

- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshableInsetForDirection:(MSRefreshDirection)direction
{
    if (direction == MSRefreshDirectionTop)
    {
        return 66;
    }
    else if (direction == MSRefreshDirectionBottom)
    {
        return 2;
    }
    
    return 60;
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller canEngageRefreshDirection:(MSRefreshDirection)direction
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrowBot.transform = CGAffineTransformIdentity;
    _labelTop.text = RELEASE_TO_LOAD;
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didDisengageRefreshDirection:(MSRefreshDirection)direction
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
    _labelTop.text = PULL_TO_REFRESH;
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didEngageRefreshDirection:(MSRefreshDirection)direction
{
    _activityViewTop.hidden = NO;
    [_activityViewTop startAnimating];
    _arrowBot.hidden = YES;
    [_rainbowBot startAnimating];
    
    if (direction == MSRefreshDirectionTop)
    {
        _activityViewTop.hidden = NO;
        [_activityViewTop startAnimating];
        
        _labelTop.text = LOADING;
    }
    else if(direction == MSRefreshDirectionBottom)
    {
        _labelBot.hidden = NO;
        _activityViewBot.hidden = NO;
        [_activityViewBot startAnimating];
    }
    
    [_delegate customPullToRefreshShouldRefresh:self withDirection:direction];
}

#pragma mark - Animation

- (CABasicAnimation *) addAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    animation.duration = 1.0f;
    animation.repeatCount = INFINITY;
    
    return animation;
}

@end
