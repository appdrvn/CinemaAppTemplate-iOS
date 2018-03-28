//
//  MovieDetailHeaderView.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/25/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieDetailHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
- (void) updateDisplay:(NSString *)trailerUrl;

@end
