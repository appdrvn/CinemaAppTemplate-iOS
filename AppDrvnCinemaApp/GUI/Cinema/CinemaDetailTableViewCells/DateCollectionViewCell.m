//
//  DateCollectionViewCell.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 12/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "GeneralHelper.h"

@interface DateCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DateCollectionViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.dayLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(ChooseDateUIModel *)model selectedDate:(NSDate *)selectedDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"(EEE)"];
    self.dayLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[GeneralHelper getDateFromTimestamp:model.timestamp]]];
    
    [dateFormatter setDateFormat:@"dd,MMM"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[GeneralHelper getDateFromTimestamp:model.timestamp]]];
    
    if ([[GeneralHelper getDateFromTimestamp:model.timestamp] compare:selectedDate] == NSOrderedSame)
    {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        self.dayLabel.textColor = [UIColor whiteColor];
        self.dateLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.dayLabel.textColor = [UIColor blackColor];
        self.dateLabel.textColor = [UIColor blackColor];
    }
}

@end
