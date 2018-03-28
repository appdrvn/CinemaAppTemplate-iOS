//
//  CinemaTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/23/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "CinemaTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CinemaTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *labelBgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation CinemaTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.subtitleLabel.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(CinemaModel *)model
{
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imageUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@", model.address];
}

@end
