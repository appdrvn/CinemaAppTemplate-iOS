//
//  BaseViewController.m
//  AppDrvnCinemaApp
//
//  Created by Tang Kean Yong on 1/3/18.
//  Copyright © 2018 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowNowVisible:) name:UIWindowDidBecomeVisibleNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowNowHidden:) name:UIWindowDidBecomeHiddenNotification object:self.view.window];
}

- (void)windowNowVisible:(NSNotification *)notification
{
    if ( [self isVideoPlayerWindow:notification.object] )
    {
        // Do what's needed if it is a video
        // For example, on a live streaming radio app, I would stop the audio if a video is started
        [self rotateLandscape:NO];
    }
    else
    {
        NSLog(@"Youtube/ Media window appears->No, Is Not video");
    }
}

- (void)windowNowHidden:(NSNotification *)notification
{
    [self performSelector:@selector(rotatePortrait) withObject:nil afterDelay:0.2];
}

- (BOOL)isVideoPlayerWindow:(id)notificationObject
{
    /*
     Define non video classes here, add more if you need it
     */
    NSArray *nonVideoClasses = @[@"_UIAlertControllerShimPresenterWindow",
                                 @"UITextEffectsWindow",
                                 @"UIRemoteKeyboardWindow"
                                 ];
    
    BOOL isVideo = YES;
    for ( NSString *testClass in nonVideoClasses )
    {
        isVideo = isVideo && ! [notificationObject isKindOfClass:NSClassFromString(testClass)];
    }
    
    return isVideo;
}

- (void) rotateLandscape:(BOOL)rotate
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setShouldRotate:YES]; // or NO to disable rotation
    if (rotate)
    {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
    }
}

- (void) rotatePortrait
{
    //    NSLog(@"rotateToPortrait");
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setShouldRotate:NO]; // or NO to disable rotation
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
