//
//  MoreUIModel.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 01/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "MoreUIModel.h"

@implementation MoreUIModel

+ (id) MoreUIModelWithTitle:(NSString *)title
{
    MoreUIModel *model = [MoreUIModel new];
    model.title = title;
    
    return model;
}

@end
