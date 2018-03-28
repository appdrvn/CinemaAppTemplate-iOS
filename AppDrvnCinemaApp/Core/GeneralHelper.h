//
//  GeneralHelper.h
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GeneralHelper : NSObject

#pragma mark - View Title
+ (UILabel *) setNavTitle:(NSString *)title withNavItem:(UINavigationItem *)navItem;

#pragma mark - Open Safari
+ (void) openBrowserInUrl:(NSString *)urlString;

#pragma mark - Show Alert Message
+ (void)showAlertMsg:(NSString *)msg;

#pragma mark - Devices Screens Resolution
+ (BOOL) isDeviceiPhone4;
+ (BOOL) isDeviceiPhone5;
+ (BOOL) isDeviceiPhone6;
+ (BOOL) isDeviceiPhone6plus;
+ (BOOL) isDeviceiPhoneX;

#pragma mark - Get Date from timestamp
+ (NSDate *) getDateFromTimestamp:(NSTimeInterval)timeStamp;

#pragma mark - Open to Waze with passing destination coordinate
+ (void) navigateToLatitude:(double)latitude longitude:(double)longitude;

#pragma mark - Open to Google Map with passing destination coordinate
+ (void) navigateToGoogleMapWithLatitude:(double)latitude longitude:(double)longitude;

@end
