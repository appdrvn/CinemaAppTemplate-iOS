//
//  MovieDetailViewController.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "MovieModel.h"

@interface MovieDetailViewController : BaseViewController

@property (nonatomic) BOOL isFromCinemaVC;
@property (nonatomic, strong) MovieModel *selectedMovieModel;

@end
