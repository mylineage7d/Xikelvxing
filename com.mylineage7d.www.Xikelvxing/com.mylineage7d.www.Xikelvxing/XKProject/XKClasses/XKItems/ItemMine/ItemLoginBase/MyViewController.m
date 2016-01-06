//
//  MyViewController.m
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

-(void)loadView {
    self.myV = [[MyView alloc] initWithFrame:Main_Screen];
    self.view = self.myV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置状态跳转
//    [self setState];
    
    // 设置button事件
    [self setLogin];
}

#pragma mark ---- 根据状态
- (void)setState {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
//    NSLog(@"%@",[userDefaults objectForKey:@"state"]);
//    if ([[userDefaults objectForKey:@"state"] isEqualToString:@"login"]) {
//        [self loginButtonAction];
//    }
}

#pragma mark ---- 设置button事件
- (void)setLogin {
    [self.myV.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginButtonAction {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
//    [self setState];
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
