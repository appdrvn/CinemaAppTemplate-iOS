//
//  MovieModel.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/21/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *trailerUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSArray *subtitles;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSString *runningTime;
@property (nonatomic, strong) NSString *director;
@property (nonatomic, strong) NSString *cast;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *distributor;
@property (nonatomic, strong) NSArray *showtimes;

@end
