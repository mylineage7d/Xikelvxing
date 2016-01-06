//
//  WriteCommentViewController.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/25.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "WriteCommentViewController.h"

@interface WriteCommentViewController ()<UITextViewDelegate>

@end

@implementation WriteCommentViewController

- (void)loadView {
    self.writeCommentV = [[WriteCommentView alloc] initWithFrame:Main_Screen];
    self.view = self.writeCommentV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置NavBar
    [self setNavBar];
}

#pragma mark ---- UITextView代理方法
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.writeCommentV.label.text = @"说一说此刻的想法...";
    } else {
        self.writeCommentV.label.text = @"";
    }
    
}

#pragma mark ---- 设置NavBar
- (void)setNavBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_send_light_sketch"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

// 评论发送
- (void)rightBarButtonAction {

    NSLog(@"%@",self.esPlaceId);
    
    AVUser *currentUser = [AVUser currentUser];
    AVObject *post = [AVObject objectWithClassName:@"PlaceComment"];

    [post setObject:self.writeCommentV.textView.text forKey:@"content"];
    [post setObject:self.esPlaceId forKey:@"esPlaceId"];
    [post setObject:currentUser.objectId forKey:@"userId"];
    
    [post save];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"评论成功"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.writeCommentV.textView.delegate = self;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.writeCommentV.textView.delegate = nil;
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
