//
//  AboutTableViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "AboutTableViewCell.h"

@interface AboutTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contributedLabel;

@end

@implementation AboutTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.contributedLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.contentLabel.preferredMaxLayoutWidth = screenRect.size.width - 15 - 15;
}

- (void) updateDisplay:(AboutUIModel *)model
{
    self.contributedLabel.text = [NSString stringWithFormat:@"%@", model.referenceName];
    self.contentLabel.text = [NSString stringWithFormat:@"by %@", model.referenceAuthor];
}

@end
