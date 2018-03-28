//
//  MoreTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 01/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MoreTableViewCell.h"

@interface MoreTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MoreTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(MoreUIModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.title];
}

@end
