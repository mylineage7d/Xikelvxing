//
//  AppDelegate.m
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    RootTabBarController *tabBarVC = [[RootTabBarController alloc] init];
    self.window.rootViewController = tabBarVC;
    
    // clenCloud
    [AVOSCloud setApplicationId:@"jexxdh9kibb9rr355pwzrp88isyvazkbl3lqcc7lw6jyaqfo"
                      clientKey:@"j4y1dc8bywtybqp50gm0xxb2k3bourvv61z3oz7ogq2kl8x5"];
    
    // 友盟
    [UMSocialData setAppKey:@"5662a16f67e58e8237000507"];
    
    [UMSocialQQHandler setQQWithAppId:@"1104777499" appKey:@"7kc63hIUUoewwcU0" url:@"http://www.umeng.com/social"];
    
    [UMSocialWechatHandler setWXAppId:@"wx21b45e4600d18412" appSecret:@"fce1c892c1d61fafb1750268faaf9c6c" url:@"http://www.umeng.com/social"];
    
//    [ShuClient initSharedInstanceWithKey:@"cf08bc5c6d879230993493cedf7afdf20bea389c" projectID:@"3a8bfeef9d"];
//    [[ShuClient sharedInstance] track:@"ios_launched" properties:nil];
//    [[ShuClient sharedInstance] flushQueue];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    [userDefaults removeObjectForKey:@"$device_agent"];
//    [userDefaults removeObjectForKey:@"$device_os"];
//    [userDefaults removeObjectForKey:@"$device_resolution"];
//    [userDefaults removeObjectForKey:@"$device_mobile"];
//    
//    [userDefaults synchronize];
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

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}


@end
