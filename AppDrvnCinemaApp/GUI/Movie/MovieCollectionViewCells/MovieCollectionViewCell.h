//
//  MovieCollectionViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/21/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieCollectionViewCell : UICollectionViewCell

@property (nonatomic) BOOL fontSmaller;
- (void) updateDisplay:(MovieModel *)model;

@end
