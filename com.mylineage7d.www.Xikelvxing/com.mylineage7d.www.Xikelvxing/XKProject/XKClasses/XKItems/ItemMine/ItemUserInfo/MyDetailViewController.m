//
//  MyDetailViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MyDetailViewController.h"
@interface MyDetailViewController ()

@end

@implementation MyDetailViewController

- (void)loadView {
    self.myDetailV = [[MyDetail alloc] initWithFrame:Main_Screen];
    self.view = self.myDetailV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [AVUser currentUser];
    
    // 根据状态跳转
//    [self setState];
    
    // 设置button事件
    [self setButtonActions];
    
    // 设置数据
    [self setData];
}

#pragma mark ---- 根据状态
- (void)setState {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"login" forKey:@"state"];
    
    [userDefaults synchronize];
    
    if ([[userDefaults objectForKey:@"controller"] isEqualToString:@"RecCellDetailViewController"]) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }
}

#pragma mark ---- 设置数据
- (void)setData {
    
//    NSLog(@"%@",self.info);
    
    NSString *imageUrl = [[self.info objectForKey:@"raw-user"] objectForKey:@"avatar_hd"];
    
    [self.myDetailV.userHeadIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.myDetailV.userName.text = [self.info objectForKey:@"username"];
    [self.myDetailV.userName sizeToFit];
    
    [self.myDetailV layoutIfNeeded];
}

// 设置按钮事件
- (void)setButtonActions {
    
    UITapGestureRecognizer *weiboTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiboTapAction)];
    UITapGestureRecognizer *weChatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weChatAction)];
    UITapGestureRecognizer *talkTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(talkTapAction)];
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTapAction)];
    
    [self.myDetailV.weiboV addGestureRecognizer:weiboTap];
    [self.myDetailV.weChatV addGestureRecognizer:weChatTap];
    [self.myDetailV.talkV addGestureRecognizer:talkTap];
    [self.myDetailV.shareAppV addGestureRecognizer:shareTap];
    
    [self.myDetailV.exitButton addTarget:self action:@selector(exitButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)weiboTapAction {
    NSLog(@"微博");
}

- (void)weChatAction {
    NSLog(@"微信");
}

- (void)talkTapAction {
    NSLog(@"聊聊");
}

- (void)shareTapAction {
    NSLog(@"分享");
}

// 退出当前账号
- (void)exitButtonAction {
    
    [AVUser logOut];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    [userDefaults setObject:@"nil" forKey:@"state"];
//    [userDefaults setObject:@"nil" forKey:@"controller"];
//    [userDefaults setObject:@"nil" forKey:@"SNS"];
//    
//    [userDefaults synchronize];
    
    NSLog(@"退出登录");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;

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
