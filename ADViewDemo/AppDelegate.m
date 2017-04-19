//
//  AppDelegate.m
//  ADViewDemo
//
//  Created by dfhb@rdd on 17/3/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WGADView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ViewController *vc = [ViewController new];
    vc.title = @"viewController";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    WGADView *adview = [WGADView adviewToWindow:self.window buttonType:WGSkipButtonTypeCircleTime tapHandle:^(WGADView *adView, NSInteger index) {
        NSLog(@"index:%@", @(index));
        if (index == 0) {
            [adView dismissWithAnimated:NO];
        }
        if (index == 1) {
            [adView dismiss];
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor whiteColor];
            vc.title = @"webView";
            [nav pushViewController:vc animated:YES];
        }
    }];

    NSString *url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490158649193&di=f937d1d1446b360ecb83d3ec2d69c74a&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e1445757ee930000018c1b51cf31.png";
    url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492060590755&di=5c787b55502ee58982c0f85a27ccf031&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F18%2F20150518210234_dtBfG.jpeg";
    adview.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
    adview.duration = 8;
    [adview reloadAdImageWithUrl:url];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
