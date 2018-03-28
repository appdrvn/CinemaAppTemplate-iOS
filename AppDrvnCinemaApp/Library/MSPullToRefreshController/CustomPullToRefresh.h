//
//  CustomPullToRefresh.h
//  PullToRefreshDemo
//
//  Created by John Wu on 3/22/12.
//  Copyright (c) 2012 TFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MSPullToRefreshController.h"

@protocol CustomPullToRefreshDelegate;

@interface CustomPullToRefresh : NSObject <MSPullToRefreshDelegate>

@property (nonatomic, strong) UIImageView * rainbowBot;
@property (nonatomic, strong) UIImageView * arrowBot;
@property (nonatomic, strong) UILabel * labelTop;
@property (nonatomic, strong) UILabel * labelBot;

@property (nonatomic, strong) MSPullToRefreshController * pullToRefreshController;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIActivityIndicatorView * activityViewBot;
@property (nonatomic, strong) UIActivityIndicatorView * activityViewTop;
@property (nonatomic, strong) id <CustomPullToRefreshDelegate> delegate;

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <CustomPullToRefreshDelegate>)delegate;
- (void)endRefresh;
- (void)startRefresh;
- (CABasicAnimation *)addAnimation;

@end

@protocol CustomPullToRefreshDelegate <NSObject>

- (void) customPullToRefreshShouldRefresh:(CustomPullToRefresh *)ptr withDirection:(MSRefreshDirection)theDirection;

@end