//
//  ChooseDateUIModel.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 12/03/2018.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseDateUIModel : NSObject

@property (nonatomic) NSTimeInterval timestamp;

+ (id) ChooseDateUIModelWithTimestamp:(NSTimeInterval)timestamp;

@end
