//
//  AppConstants.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#define ABOUT_US_FACEBOOK_LINK @"https://www.facebook.com/Appdrvn/"
#define ABOUT_US_WEBSITE_LINK @"http://www.appdrvn.com/"
#define ABOUT_US_MAIL_ADDRESS @"hello@appdrvn.com"
#define ABOUT_CONTENT @"Cinema Template is an effort from Appdrvn to provide a mobile application template. Aiming to assist new startup to speed up their development of mobile application. Below are some parties we would like highlight, some of them are libraries that are being used in template, some of them are the author of icon resources in this template."

#define DEFAULT_TAKE 8

#define BANNER_VIEW_HEIGHT ([[UIScreen mainScreen] bounds].size.width * 13) / 16 // Ratio 16:13
#define CINEMA_VIEW_HEIGHT ([[UIScreen mainScreen] bounds].size.width * 9) / 16 // Ratio 16:9

#endif /* AppConstants_h */


#import <UIKit/UIKit.h>

@interface UIColor (custom)

+ (UIColor *)appThemeColor;

@end

@implementation UIColor (custom)

+ (UIColor *)appThemeColor
{
    return [UIColor colorWithRed:43.0f/255.0f green:132.0f/255.0f blue:211.0f/255.0f alpha:1.0];
}

@end
