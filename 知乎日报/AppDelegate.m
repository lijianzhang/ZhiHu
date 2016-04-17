//
//  AppDelegate.m
//  知乎日报
//
//  Created by Jz on 16/4/7.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "RequestTool.h"
#import "JZNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    JZNavigationController *navigationController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JZNavigationController"];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    [users setBool:YES forKey:@"Theme"];
    [users synchronize];
    [self setLaunchScreen];
    return YES;
}

- (void)setLaunchScreen{

    UIImageView *two = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window addSubview:two];
    two.contentMode = UIViewContentModeScaleAspectFill;
    UIImageView *one = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window addSubview:one];
    one.image = [UIImage imageNamed:@"Default"];


    [[RequestTool shardRequest]getLaunchImageWihtSuccess:^(id requestData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *url = requestData[@"img"];
            [two sd_setImageWithURL:[NSURL URLWithString:url]];
            [UIView animateWithDuration:2.0f animations:^{
                one.alpha = 0;
                two.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }completion:^(BOOL finished) {
                [one removeFromSuperview];
                [two removeFromSuperview];
            }];
        });
        
    } andFail:nil];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
