//
//  MovieTitleTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieTitleTableViewCell.h"

@interface MovieTitleTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MovieTitleTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.titleLabel.preferredMaxLayoutWidth = screenRect.size.width - 20;
}

- (void) updateDisplay:(MovieDetailUIModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.content];
}

@end
