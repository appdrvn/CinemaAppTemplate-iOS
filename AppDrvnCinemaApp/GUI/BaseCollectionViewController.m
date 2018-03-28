//
//  BaseCollectionViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/3/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullToRefresh = [[CustomPullToRefresh alloc] initWithScrollView:self.currentCollectionView delegate:self];
    self.pullToRefresh.activityViewTop.color = [UIColor blackColor];
    self.pullToRefresh.labelTop.textColor = [UIColor blackColor];
    
    self.currentCollectionView.backgroundColor = [UIColor clearColor];
    self.currentCollectionView.alwaysBounceVertical = YES;
    
    [self.currentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    /* for load more - Start */
    [self.currentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    /* for load more - End */
}

#pragma mark UICollectionViewDelegate

/* for load more - Start */
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.canLoadMore)
    {
        return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 50+60);
    }
    else
    {
        return CGSizeZero;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    
    // If want to load more, just copy this to the certain class file - Start
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableview.backgroundColor = [UIColor clearColor];
        
        [self.activityViewBot removeFromSuperview];
        self.activityViewBot = [[UIActivityIndicatorView alloc] init];
        self.activityViewBot.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-50, 50/2 - 5 , 12, 12);
        self.activityViewBot.color = [UIColor blackColor];
        [reusableview addSubview:self.activityViewBot];
        [self.activityViewBot startAnimating];
        
        [self.loadMoreLabel removeFromSuperview];
        self.loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.activityViewBot.frame.origin.x+self.activityViewBot.frame.size.width+15, self.activityViewBot.frame.origin.y+(self.activityViewBot.frame.size.height/4), [[UIScreen mainScreen] bounds].size.width, 44)];
        self.loadMoreLabel.backgroundColor = [UIColor clearColor];
        self.loadMoreLabel.text = [NSString stringWithFormat:@"Load More"];
        self.loadMoreLabel.textColor = [UIColor blackColor];
        self.loadMoreLabel.font = [UIFont systemFontOfSize:11.0f];
        self.loadMoreLabel.textAlignment = NSTextAlignmentCenter;
        [reusableview addSubview:self.loadMoreLabel];
        [self.loadMoreLabel sizeToFit];
        self.loadMoreLabel.frame = CGRectMake(self.activityViewBot.frame.origin.x+self.activityViewBot.frame.size.width+15, self.activityViewBot.frame.origin.y+(self.activityViewBot.frame.size.height/2)-(self.loadMoreLabel.frame.size.height/2), self.loadMoreLabel.frame.size.width, self.loadMoreLabel.frame.size.height);
        
        return reusableview;
    }
    // If want to load more, just copy this to the certain class file - End
    
    return reusableview;
}
/* for load more - End */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    return cell;
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
    [self.currentCollectionView reloadData];
    
    NSInteger data = [self.currentCollectionView numberOfItemsInSection:0];
    if(data > 0)
    {
        // If you have set the global empty view, you may hide/remove the global empty view here
    }
    else
    {
        if (self.shouldShowNoDataImageViewAndLabel)
        {
            // If need to set global empty view, you may set at here
        }
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
}

/* for load more - Start */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height-250)
    {
        // we are at the end
        if (!self.canLoadMore || self.isLoadingMore)
        {
            return;
        }
        else
        {
            // Load more
            self.isLoadingMore = true;
            [self loadData];
        }
    }
}
/* for load more - End */


@end
