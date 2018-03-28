//
//  BuyNowViewController.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 08/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "MovieModel.h"

@interface BuyNowViewController : BaseViewController

@property (nonatomic) BOOL isFromMovieDetialVC;
@property (nonatomic, strong) MovieModel *selectedMovieModel;

@end
