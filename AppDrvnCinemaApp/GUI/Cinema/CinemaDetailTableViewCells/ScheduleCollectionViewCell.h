//
//  ScheduleCollectionViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowTimeModel.h"

@interface ScheduleCollectionViewCell : UICollectionViewCell

- (void) updateDisplay:(ShowTimeModel *)model;

@end
