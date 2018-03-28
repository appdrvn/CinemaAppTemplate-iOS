//
//  DateCollectionViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 12/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateUIModel.h"

@interface DateCollectionViewCell : UICollectionViewCell

- (void) updateDisplay:(ChooseDateUIModel *)model selectedDate:(NSDate *)selectedDate;

@end
