//
//  selectViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/11/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "selectViewController.h"

@interface selectViewController ()

@end

@implementation selectViewController

- (void)loadView{
    _selectV = [[selectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _selectV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *selectCityButton = [[UIBarButtonItem alloc] initWithCustomView:self.selectV.selectCityButton];
    selectCityButton.enabled = NO;
    self.navigationItem.leftBarButtonItem = selectCityButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:self.selectV.backButton];
    self.navigationItem.rightBarButtonItem = backButton;
    
    // 按钮方法
    [self.selectV.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    // 手势
    [self.selectV.shouerTap addTarget:self action:@selector(shouerTapAction)];
    [self.selectV.jizhoudaoTap addTarget:self action:@selector(jizhoudaoTapAction)];
    
    // Do any additional setup after loading the view.
}

#pragma marl --- 点击事件
- (void)backButtonAction:(UIButton *)sender{
    
    [self backAnimation];
    [[self navigationController] popViewControllerAnimated:NO];
}

- (void)shouerTapAction{
    NSString *string1 = @"shouer";
    _block(string1);
    
    [self backAnimation];
    [[self navigationController] popViewControllerAnimated:NO];
}

- (void)jizhoudaoTapAction{
    NSString *string2 = @"jizhoudao";
    _block(string2);
    
    [self backAnimation];
    [[self navigationController] popViewControllerAnimated:NO];
}

#pragma mark ---- 返回动画
- (void)backAnimation{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

#pragma mark --- block方法
- (void)sendMessage:(SendMessageBlock)block{
    _block = block;
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
