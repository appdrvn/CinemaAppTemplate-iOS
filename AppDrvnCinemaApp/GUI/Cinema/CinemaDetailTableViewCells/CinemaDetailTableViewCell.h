//
//  CinemaDetailTableViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface CinemaDetailTableViewCell : UITableViewCell

@property id delegate;
@property (nonatomic) NSInteger currentIndex;
- (void) updateDisplay:(MovieModel *)model;

@end

@protocol CinemaDetailTableViewCellDelegate <NSObject>

- (void) CinemaDetailTableViewCellDelegateDidClickAtIndex:(NSInteger)index;
- (void) CinemaDetailTableViewCellDelegateDidSelectedTimeAtCellIndex:(NSInteger)cellIndex withSelected:(NSInteger)selected;

@end
