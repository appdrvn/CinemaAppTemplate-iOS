//
//  ScheduleCollectionViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "ScheduleCollectionViewCell.h"

@interface ScheduleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ScheduleCollectionViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.timeLabel.backgroundColor = [UIColor clearColor];
    
    self.separatorLine.layer.shadowColor = [UIColor blackColor].CGColor;
    self.separatorLine.layer.shadowOffset = CGSizeMake(0, 1);
    self.separatorLine.layer.shadowOpacity = 1;
    self.separatorLine.layer.shadowRadius = 5.0;
    self.separatorLine.clipsToBounds = NO;
}

- (void) updateDisplay:(ShowTimeModel *)model
{
    self.timeLabel.text = [NSString stringWithFormat:@"%@\n%@", model.time, model.session];
}

@end
