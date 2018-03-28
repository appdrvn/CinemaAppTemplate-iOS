//
//  CinemaModel.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/23/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaModel : NSObject

@property (nonatomic, strong) NSString *cinemaId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *phoneNo;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic, strong) NSArray *showtimes;

@end
