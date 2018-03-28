//
//  MovieSynopsisTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieSynopsisTableViewCell.h"

@interface MovieSynopsisTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation MovieSynopsisTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.synopsisLabel.backgroundColor = [UIColor clearColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.synopsisLabel.preferredMaxLayoutWidth = screenRect.size.width - 20;
}

- (void) updateDisplay:(MovieDetailUIModel *)model
{
    self.synopsisLabel.text = [NSString stringWithFormat:@"%@", model.content];
}

@end
