//
//  AppDelegate.m
//  mine
//
//  Created by Shuwei on 16/5/26.
//  Copyright © 2016年 jov. All rights reserved.
//

#import "AppDelegate.h"
#import "DBHelper.h"
#import "Common.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    DBHelper *db = [DBHelper sharedInstance];
    if([db openDB]){
        NSInteger cnt = [db getCnt];
        if(cnt==0){
            [db initData:nil];
            SettingBean *bean = [[SettingBean alloc] init];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app版本
            NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            // app build版本
            NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
            bean.key = @"ver";
            bean.version = appVersion;
            bean.buildno = appBuild;
            [db saveSetting:bean];
        }else {
            SettingBean *bean = [db getSetting:@"ver"];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app版本
            NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            // app build版本
            NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
            if(bean){
                if(![bean.version isEqualToString:appVersion]||![bean.buildno isEqualToString:appBuild]){
                    [db deleteData];
                    [db initData:nil];
                    bean = [[SettingBean alloc] init];
                    bean.key = @"ver";
                    bean.version = appVersion;
                    bean.buildno = appBuild;
                    [db saveSetting:bean];
                }
            }else{
                [db deleteData];
                [db initData:nil];
                bean = [[SettingBean alloc] init];
                bean.key = @"ver";
                bean.version = appVersion;
                bean.buildno = appBuild;
                [db saveSetting:bean];
            }
        }
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self.window  makeKeyAndVisible];
    [[UINavigationBar appearance] setBarTintColor:[Common colorWithHexString:@"89692E"]];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [UINavigationBar appearance].titleTextAttributes=dict;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    return YES;
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
