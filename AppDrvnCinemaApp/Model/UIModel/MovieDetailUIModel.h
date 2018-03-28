//
//  MovieDetailUIModel.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerEnum.h"

@interface MovieDetailUIModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) MovieDetailCellTypes cellType;

+ (id) MovieDetailUIModelWithContent:(NSString *)content cellType:(MovieDetailCellTypes)cellType;

+ (id) MovieDetailUIModelWithTitle:(NSString *)title content:(NSString *)content cellType:(MovieDetailCellTypes)cellType;

@end
