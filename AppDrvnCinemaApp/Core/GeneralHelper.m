//
//  GeneralHelper.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 9/27/17.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "GeneralHelper.h"

@implementation GeneralHelper

#pragma mark - View Title
+ (UILabel *) setNavTitle:(NSString *)title withNavItem:(UINavigationItem *)navItem
{
    NSString *temp = title;
    if ([temp length] > 19)
    {
        NSRange range = [temp rangeOfComposedCharacterSequencesForRange:(NSRange){0, 19}];
        temp = [temp substringWithRange:range];
        temp = [temp stringByAppendingString:@"..."];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, navItem.titleView.frame.size.width-20, 40)];
    label.text = [temp uppercaseString];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

#pragma mark - Open Safari
+ (void) openBrowserInUrl:(NSString *)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

#pragma mark - Show Alert Message
+ (void)showAlertMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - Devices Screens Resolution
+ (BOOL) isDeviceiPhone4
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone5
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone6
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone6plus
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhoneX
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 812)
    {
        return YES;
    }
    return NO;
}

#pragma mark - Get Date from timestamp
+ (NSDate *) getDateFromTimestamp:(NSTimeInterval)timeStamp
{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}

#pragma mark - Open to Waze with passing destination coordinate
+ (void) navigateToLatitude:(double)latitude longitude:(double)longitude
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]])
    {
        // Waze is installed. Launch Waze and start navigation
        NSString *urlStr = [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes", latitude, longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    else
    {
        // Waze is not installed. Launch AppStore to install Waze app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
    }
}

#pragma mark - Open to Google Map with passing destination coordinate
+ (void) navigateToGoogleMapWithLatitude:(double)latitude longitude:(double)longitude
{
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/?daddr=%f,%f", latitude, longitude ];
    
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:urlStr]];
}


@end
