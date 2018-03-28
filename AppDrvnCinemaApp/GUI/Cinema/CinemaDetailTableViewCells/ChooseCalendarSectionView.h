//
//  ChooseCalendarSectionView.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/20/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCalendarSectionView : UIView

@property id delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
- (void) updateDisplay:(NSMutableArray *)dates selectedDate:(NSDate *)selectedDate;

@end

@protocol ChooseCalendarSectionViewDelegate <NSObject>

- (void) ChooseCalendarSectionViewDelegateDidSelectedTimeStamp:(NSTimeInterval)selectedTimeStamp atIndexPath:(NSIndexPath *)indexPath;

@end
