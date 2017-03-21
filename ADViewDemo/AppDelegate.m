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
    
    WGADView *adview = [WGADView adviewToWindow:self.window buttonType:0 tapHandle:^(NSInteger index) {
        NSLog(@"index:%@", @(index));
        if (index == 1) {
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor whiteColor];
            vc.title = @"webView";
            [nav pushViewController:vc animated:YES];
        }
    }];
    adview.buttonType = WGSkipButtonTypeCircleTime;
    NSString *url = @"https://bjbgp02.baidupcs.com/file/1d27693666729daf780597c9b9614562?bkt=p3-14001d27693666729daf780597c9b96145620264ce41000000029f99&fid=3878415752-250528-525904037071361&time=1490075084&sign=FDTAXGERLBHS-DCb740ccc5511e5e8fedcff06b081203-mOheBJr93FH%2BjZKyS9RWJUVaMfQ%3D&to=76&size=171929&sta_dx=171929&sta_cs=0&sta_ft=png&sta_ct=0&sta_mt=0&fm2=MH,Yangquan,Netizen-anywhere,,beijingpbs&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=14001d27693666729daf780597c9b96145620264ce41000000029f99&sl=72286287&expires=8h&rt=pr&r=109941698&mlogid=1845516532830421821&vuk=3878415752&vbdid=1322237120&fin=launch%402x.png&fn=launch%402x.png&rtype=1&iv=0&dp-logid=1845516532830421821&dp-callid=0.1.1&hps=1&csl=400&csign=ix%2Bl5hyOvcsdx%2FawXCO9QUNBNr4%3D&by=themis";
//    url = @"http://blog.163.com/gjw_1991/album/#m=2&aid=304314113&pid=9768460898";
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
