//
//  BaseTableViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/3/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BaseTableViewController.h"

#define FOOTER_HEIGHT 50

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentTableView.backgroundColor = [UIColor clearColor];

    self.pullToRefresh = [[CustomPullToRefresh alloc] initWithScrollView:self.currentTableView delegate:self];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark Protected
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.canLoadMore = true;
    self.currentPage = 1;
}

- (void)triggerManualRefresh
{
    [self.pullToRefresh startRefresh];
}

- (void)doneLoading
{
    self.isRefreshing = false;
    self.isLoadingMore = false;
    [self.pullToRefresh endRefresh];
    [self.currentTableView reloadData];
    
    NSInteger data = [self.currentTableView numberOfRowsInSection:0];
    if(data > 0)
    {
        // Hide Empty Label
    }
    else
    {
        if (self.shouldShowNoDataImageViewAndLabel)
        {
            // Show Empty Label
        }
    }
    if (self.currentPage > 0 && self.canLoadMore)
    {
        [self createTableViewFooter];
    }
    else
    {
        self.currentTableView.tableFooterView = nil;
    }
}

- (void)loadData
{
    @throw [NSException exceptionWithName:@"loadData is not implemented" reason:nil userInfo:nil];
}

#pragma mark - CustomPullToRefresh Delegate Methods

- (void) customPullToRefreshShouldRefresh:(CustomPullToRefresh *)ptr withDirection:(MSRefreshDirection)theDirection
{
    if (theDirection == MSRefreshDirectionTop)
    {
        // Async loading here
        self.currentPage = 1;
        self.extraSkipCount = 0;
        self.canLoadMore = true;
        [self loadData];
        self.isRefreshing = true;
    }
    else
    {
        if (!self.canLoadMore || self.isLoadingMore)
        {
            [self doneLoading];
            return;
        }
        // Load more
        self.isLoadingMore = true;
        [self loadData];
    }
}

/* for load more - Start */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height-50)
    {
        // we are at the end
        if (!self.canLoadMore || self.isLoadingMore)
        {
            return;
        }
        // Load more
        self.isLoadingMore = true;
        [self loadData];
    }
}

- (void)createTableViewFooter
{
    CGRect footerRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, FOOTER_HEIGHT);
    UIView *tableFooterView = [[UIView alloc] initWithFrame:footerRect];
    self.currentTableView.tableFooterView = tableFooterView;
    
    self.activityViewBot = [[UIActivityIndicatorView alloc] init];
    self.activityViewBot.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-50, 50/2 - 5 , 12, 12);
    self.activityViewBot.color = [UIColor blackColor];
    [tableFooterView addSubview:self.activityViewBot];
    [self.activityViewBot startAnimating];
    
    [self.loadMoreLabel removeFromSuperview];
    self.loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.activityViewBot.frame.origin.x+self.activityViewBot.frame.size.width+15, self.activityViewBot.frame.origin.y+(self.activityViewBot.frame.size.height/4), [[UIScreen mainScreen] bounds].size.width, FOOTER_HEIGHT)];
    self.loadMoreLabel.backgroundColor = [UIColor clearColor];
    self.loadMoreLabel.text = [NSString stringWithFormat:@"Load More"];
    self.loadMoreLabel.textColor = [UIColor blackColor];
    self.loadMoreLabel.font = [UIFont systemFontOfSize:11.0f];
    self.loadMoreLabel.textAlignment = NSTextAlignmentCenter;
    [tableFooterView addSubview:self.loadMoreLabel];
    [self.loadMoreLabel sizeToFit];
    self.loadMoreLabel.frame = CGRectMake(self.activityViewBot.frame.origin.x+self.activityViewBot.frame.size.width+15, self.activityViewBot.frame.origin.y+(self.activityViewBot.frame.size.height/2)-(self.loadMoreLabel.frame.size.height/2), self.loadMoreLabel.frame.size.width, self.loadMoreLabel.frame.size.height);
}
/* for load more - End */

@end
