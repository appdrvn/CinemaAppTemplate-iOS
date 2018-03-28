//
//  PreviewViewController.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 15/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "MovieModel.h"

@interface PreviewViewController : BaseViewController

@property id delegate;
@property (nonatomic, strong) MovieModel *selectedMovieModel;

@end

@protocol PreviewViewControllerDelegate <NSObject>

- (void) PreviewViewControllerDelegateDidClickOnBuyNow;
- (void) PreviewViewControllerDelegateDidClickOnMoreInfo;

@end
