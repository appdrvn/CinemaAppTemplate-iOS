//
//  BuyNowTableViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 08/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"

@interface BuyNowTableViewCell : UITableViewCell

@property id delegate;
@property (nonatomic) NSInteger currentIndex;
- (void) updateDisplay:(CinemaModel *)model;

@end

@protocol BuyNowTableViewCellDelegate <NSObject>

- (void) BuyNowTableViewCellDelegateDidSelectedTimeAtCellIndex:(NSInteger)cellIndex withSelected:(NSInteger)selected;
- (void) BuyNowTableViewCellDelegateDidClickCinemaAtCellIndex:(NSInteger)cellIndex;

@end
