//
//  BuyNowHeaderView.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 08/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface BuyNowHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property id delegate;
- (void) updateDisplay:(MovieModel *)model;

@end

@protocol BuyNowHeaderViewDelegate <NSObject>

- (void) BuyNowHeaderViewDelegateDidClickOn;

@end
