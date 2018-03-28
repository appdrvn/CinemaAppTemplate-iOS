//
//  MovieDetailUIModel.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/24/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MovieDetailUIModel.h"

@implementation MovieDetailUIModel

+ (id) MovieDetailUIModelWithContent:(NSString *)content cellType:(MovieDetailCellTypes)cellType
{
    MovieDetailUIModel *model = [MovieDetailUIModel new];
    model.content = content;
    model.cellType = cellType;
    
    return model;
}

+ (id) MovieDetailUIModelWithTitle:(NSString *)title content:(NSString *)content cellType:(MovieDetailCellTypes)cellType
{
    MovieDetailUIModel *model = [MovieDetailUIModel new];
    model.title = title;
    model.content = content;
    model.cellType = cellType;
    
    return model;
}

@end
