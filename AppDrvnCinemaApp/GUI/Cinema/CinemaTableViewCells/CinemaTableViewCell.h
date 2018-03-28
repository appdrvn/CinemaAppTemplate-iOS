//
//  CinemaTableViewCell.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/23/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"

@interface CinemaTableViewCell : UITableViewCell

- (void) updateDisplay:(CinemaModel *)model;

@end
