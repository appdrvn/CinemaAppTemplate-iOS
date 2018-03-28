//
//  AboutHeaderView.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutHeaderView : UIView

@property id delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
- (void) updateDisplay:(NSString *)content;

@end

@protocol AboutHeaderViewDelegate <NSObject>

- (void) AboutHeaderViewDelegateDidClickOnFacebookButton;
- (void) AboutHeaderViewDelegateDidClickOnMailButton;
- (void) AboutHeaderViewDelegateDidClickOnWebsiteButton;

@end
