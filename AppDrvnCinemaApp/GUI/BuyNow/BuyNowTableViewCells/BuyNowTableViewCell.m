//
//  BuyNowTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 08/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BuyNowTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ScheduleCollectionViewCell.h"

@interface BuyNowTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *showTimeCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSArray *schedules;

@end

@implementation BuyNowTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.thumbnailImageView.backgroundColor = [UIColor clearColor];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.showTimeCollectionView.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(CinemaModel *)model
{
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    
    [self.showTimeCollectionView registerNib:[UINib nibWithNibName:@"ScheduleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ScheduleCollectionViewCell"];
    self.schedules = [NSArray new];
    self.schedules = [model.showtimes copy];
    
    self.showTimeCollectionView.dataSource = self;
    self.showTimeCollectionView.delegate = self;
}

#pragma mark UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.schedules count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScheduleCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell updateDisplay:[self.schedules objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(BuyNowTableViewCellDelegateDidSelectedTimeAtCellIndex:withSelected:)])
    {
        [self.delegate BuyNowTableViewCellDelegateDidSelectedTimeAtCellIndex:self.currentIndex withSelected:indexPath.row];
    }
}

- (CGSize)fillSizeArray:(int)index
{
    return CGSizeMake(80, 42);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fillSizeArray:(int)indexPath.row];
}

#pragma mark - UIButtons Actions
- (IBAction)thumbnailPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(BuyNowTableViewCellDelegateDidClickCinemaAtCellIndex:)])
    {
        [self.delegate BuyNowTableViewCellDelegateDidClickCinemaAtCellIndex:self.currentIndex];
    }
}

@end
