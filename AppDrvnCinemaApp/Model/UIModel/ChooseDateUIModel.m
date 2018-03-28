//
//  ChooseDateUIModel.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 12/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "ChooseDateUIModel.h"

@implementation ChooseDateUIModel

+ (id) ChooseDateUIModelWithTimestamp:(NSTimeInterval)timestamp
{
    ChooseDateUIModel *model = [ChooseDateUIModel new];
    model.timestamp = timestamp;
    
    return model;
}

@end
