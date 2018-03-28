//
//  MovieCollectionViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/21/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "GeneralHelper.h"

@interface MovieCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MovieCollectionViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    
    self.thumbnailImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.thumbnailImageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.thumbnailImageView.layer.shadowOpacity = 1;
    self.thumbnailImageView.layer.shadowRadius = 5.0;
    self.thumbnailImageView.clipsToBounds = NO;
    
    if ([GeneralHelper isDeviceiPhone4] || [GeneralHelper isDeviceiPhone5])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else
    {
        self.nameLabel.font = [UIFont systemFontOfSize:14.0f];
    }
}

- (void) updateDisplay:(MovieModel *)model
{
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
}

@end
