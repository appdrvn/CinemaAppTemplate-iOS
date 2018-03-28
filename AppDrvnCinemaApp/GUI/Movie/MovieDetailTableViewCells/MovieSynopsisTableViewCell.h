//
//  MovieSynopsisTableViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailUIModel.h"

@interface MovieSynopsisTableViewCell : UITableViewCell

- (void) updateDisplay:(MovieDetailUIModel *)model;

@end
