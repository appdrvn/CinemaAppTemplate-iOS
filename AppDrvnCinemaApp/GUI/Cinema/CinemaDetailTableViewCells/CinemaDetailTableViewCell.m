//
//  CinemaDetailTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "CinemaDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ScheduleCollectionViewCell.h"

@interface CinemaDetailTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *timesheetCollectionView;
@property (nonatomic, strong) NSArray *schedules;

@end

@implementation CinemaDetailTableViewCell
- (void) layoutSubviews
{
    [super layoutSubviews];
    self.movieNameLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.timesheetCollectionView.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(MovieModel *)model
{
    [self.timesheetCollectionView registerNib:[UINib nibWithNibName:@"ScheduleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ScheduleCollectionViewCell"];
    
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.movieNameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    self.contentLabel.text = [NSString stringWithFormat:@"%@", model.runningTime];
    
    self.schedules = [NSArray new];
    self.schedules = [model.showtimes copy];
    
    self.timesheetCollectionView.dataSource = self;
    self.timesheetCollectionView.delegate = self;
}

#pragma mark - UIButtons Actions
- (IBAction)thumbnailPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CinemaDetailTableViewCellDelegateDidClickAtIndex:)])
    {
        [self.delegate CinemaDetailTableViewCellDelegateDidClickAtIndex:self.currentIndex];
    }
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
    if ([self.delegate respondsToSelector:@selector(CinemaDetailTableViewCellDelegateDidSelectedTimeAtCellIndex:withSelected:)])
    {
        [self.delegate CinemaDetailTableViewCellDelegateDidSelectedTimeAtCellIndex:self.currentIndex withSelected:indexPath.row];
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

@end
