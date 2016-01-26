//
//  LoginViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "MyDetailViewController.h"

@interface LoginViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@property (nonatomic,strong)NSArray *permissions;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *userHead;
@end

@implementation LoginViewController

- (void)loadView {
    self.loginV = [[LoginView alloc] initWithFrame:Main_Screen];
    self.view = self.loginV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"1104777499" andAppSecret:@"7kc63hIUUoewwcU0" andRedirectURI:nil];
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSWeiXin withAppKey:@"wx21b45e4600d18412" andAppSecret:@"fce1c892c1d61fafb1750268faaf9c6c" andRedirectURI:nil];
    
    // 根据状态跳转
//    [self setState];
    
    // 设置UINavigation
    [self setNavBar];
    
    // 设置Button
    [self setButtons];
}

#pragma mark ---- 根据状态跳转
- (void)setState {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
//    [userDefaults setObject:@"login" forKey:@"state"];
//    
//    [userDefaults synchronize];
    
    if ([[userDefaults objectForKey:@"state"] isEqualToString:@"login"]) {
        if ([[userDefaults objectForKey:@"weChat"] isEqualToString:@"SNS"]) {
            [self weChatButtonAction];
        } else if ([[userDefaults objectForKey:@"QQ"] isEqualToString:@"SNS"]) {
            [self qqButtonAction];
        } else if ([[userDefaults objectForKey:@"weibo"] isEqualToString:@"SNS"]){
            [self weiboButtonAction];
        }
    }
}

#pragma mark ---- 设置Button
- (void)setButtons {
    
    [self.loginV.weChatButton addTarget:self action:@selector(weChatButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginV.qqButton addTarget:self action:@selector(qqButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginV.weiboButton addTarget:self action:@selector(weiboButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)weChatButtonAction {
    
    if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSWeiXin]) {
        
        [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
            NSLog(@"object : %@ error:%@", object, error);
            if ([self filterError:error]) {
                [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiXin block:^(AVUser *user, NSError *error) {
                    if ([self filterError:error]) {
                        
                        [self loginSucceedWithUser:user authData:object sourceVC:@"weChat"];
                        NSLog(@"object:%@",object);
                    }
                }];
            }
        } toPlatform:AVOSCloudSNSWeiXin];
    } else {
        [self alert:@"没有安装微信，暂不能登录"];
    }
}

- (void)qqButtonAction {
    
    // 如果安装了QQ，则跳转至应用，否则跳转至网页
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            NSLog(@"failed to get authentication from weibo. error: %@", error.description);
        } else {
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                if ([self filterError:error]) {
                    
                    [self loginSucceedWithUser:user authData:object sourceVC:@"qq"];
                    NSLog(@"%@",object);
                }
            }];
        }
    } toPlatform:AVOSCloudSNSQQ];
}

- (void)weiboButtonAction {
    
    // 如果安装了微博，直接跳转到微博应用，否则跳转至网页登录
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            NSLog(@"failed to get authentication from weibo. error: %@", error.description);
        } else {
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                if ([self filterError:error]) {
                    
                    [self loginSucceedWithUser:user authData:object sourceVC:@"weibo"];
//                    NSLog(@"objc:%@",object);
//                    NSLog(@"user:%@",user);
                }
            }];
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];
}

// 跳转MyDetailController
- (void)loginSucceedWithUser:(AVUser *)user authData:(NSDictionary *)authData sourceVC:(NSString *)sourceVC{
    
    MyDetailViewController *myDetailVC = [[MyDetailViewController alloc] init];
    
    myDetailVC.sourceVC = sourceVC;
    myDetailVC.info = authData;
    myDetailVC.user = user;
    
    [self.navigationController pushViewController:myDetailVC animated:YES];
}

#pragma mark ---- 设置UINavigation
- (void)setNavBar {
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_close_sketch"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarAction)];
    self.navigationItem.leftBarButtonItem = backBar;
}

- (void)backBarAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    //    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    UIColor * color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)alert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)filterError:(NSError *)error {
    if (error) {
        [self alert:[error localizedDescription]];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
