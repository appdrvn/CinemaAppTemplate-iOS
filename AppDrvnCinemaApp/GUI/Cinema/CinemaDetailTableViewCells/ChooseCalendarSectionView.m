//
//  ChooseCalendarSectionView.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "ChooseCalendarSectionView.h"
#import "DateCollectionViewCell.h"
#import "GeneralHelper.h"

@interface ChooseCalendarSectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dates;
@property (weak, nonatomic) IBOutlet UICollectionView *dateCollectionView;
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation ChooseCalendarSectionView

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

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void) updateDisplay:(NSMutableArray *)dates selectedDate:(NSDate *)selectedDate
{
    self.selectedDate = selectedDate;
    
    [self.dateCollectionView registerNib:[UINib nibWithNibName:@"DateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DateCollectionViewCell"];
    self.dateCollectionView.delegate = self;
    self.dateCollectionView.dataSource = self;
    
    self.dates = [NSArray new];
    self.dates = [dates copy];
    
    [self.dateCollectionView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveCollectionView:) name:@"NSNOTIFICATION_CENTER_MOVE_COLLECTIONVIEW" object:nil];
}

- (void) moveCollectionView:(NSNotificationCenter *)notification
{
    NSIndexPath *indexPath = (NSIndexPath *)[notification valueForKey:@"object"];
    NSLog(@"moveCollectionView->%ld", (long)indexPath.row);
    [self.dateCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void) scrollToIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dates count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCollectionViewCell" forIndexPath:indexPath];
    [cell updateDisplay:[self.dates objectAtIndex:indexPath.row] selectedDate:self.selectedDate];
    
    return cell;
}

- (CGSize)fillSizeArray:(int)index
{
    return CGSizeMake(80, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fillSizeArray:(int)indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseDateUIModel *model = (ChooseDateUIModel *)self.dates[indexPath.row];
    self.selectedDate = [GeneralHelper getDateFromTimestamp:model.timestamp];
    [collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(ChooseCalendarSectionViewDelegateDidSelectedTimeStamp:atIndexPath:)])
    {
        ChooseDateUIModel *model = (ChooseDateUIModel *)self.dates[indexPath.row];
        [self.delegate ChooseCalendarSectionViewDelegateDidSelectedTimeStamp:model.timestamp atIndexPath:indexPath];
    }
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
