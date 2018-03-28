//
//  MovieInfoTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieInfoTableViewCell.h"

@interface MovieInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dotLabel;

@end

@implementation MovieInfoTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.dotLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.contentLabel.preferredMaxLayoutWidth = screenRect.size.width - 122;
}

- (void) updateDisplay:(MovieDetailUIModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.title];
    self.dotLabel.text = [NSString stringWithFormat:@":"];
    self.contentLabel.text = [NSString stringWithFormat:@"%@", model.content];
}

@end
