//
//  DiscoverDetailViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DiscoverDetailViewController.h"
#import "PhotoViewController.h"

@interface DiscoverDetailViewController ()<UITextFieldDelegate>

@end

@implementation DiscoverDetailViewController

- (void)loadView{
    self.detailV = [[DiscoverDetailView alloc] initWithFrame:Main_Screen];
    self.view = self.detailV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  设置Views
    [self setViews];
    
    // 设置数据
    [self setDatas];
    
    // 设置通知
    [self setNotification];
}

#pragma mark ---- 设置Views
- (void)setViews {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction)];
    [self.detailV.main_pic addGestureRecognizer:tap];
}

// Tap点击方法
- (void)tapImageAction {
    PhotoViewController *photoVC = [PhotoViewController new];
    photoVC.imageArray = self.model.imageUrls;
    [self.navigationController pushViewController:photoVC animated:YES];
}

#pragma mark ---- 设置通知
- (void)setNotification{
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
}

// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification{
    
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    
    [keyboardObject getValue:&keyboardRect];
    
    //设置view的frame，往上平移
    self.detailV.frame = CGRectMake(0,- keyboardRect.size.height + 64, Max_Width, self.detailV.frame.size.height);
    [UIView commitAnimations];
    
    [self.detailV layoutIfNeeded];
}

//键盘消失时
-(void)keyboardDidHidden{

    //设置view的frame，往下平移
    self.detailV.frame = CGRectMake(0, 64, Max_Width, self.detailV.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark ---- 设置数据
- (void)setDatas{
    
    [self.detailV.headImage sd_setImageWithURL:[NSURL URLWithString:self.model.avatarUrl]];
    
    self.detailV.nameLabel.text = self.model.username;

    [self.detailV.main_pic sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrls[0]]];
    
    self.detailV.content.text = self.model.content;
    
    AVQuery *query = [AVQuery queryWithClassName:@"MomentLike"];
    [query whereKey:@"momentId" equalTo:self.model.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {

            // 检索成功
            NSLog(@"Successfully retrieved %ld posts.", objects.count);
            
            
            
            NSMutableSet *set = [NSMutableSet set];
            for (AVObject *ob in objects) {
//                [array addObject:[ob objectForKey:@"userId"]];
                [set addObject:[ob objectForKey:@"userId"]];
            }
            
            NSArray *userArray = [set allObjects];
            NSLog(@"user:%@",userArray);
            
//            NSMutableArray *array = [NSMutableArray new];
            
//            for (NSString *str in userArray) {
//                AVQuery *query = [AVQuery queryWithClassName:@"User"];
//                AVObject *post = [query getObjectWithId:str];
//                [array addObject:[post objectForKey:@"avatarUrl"]];
//            }
            
//            for (int i = 0; i < userArray.count; i++) {
//                AVQuery *query = [AVQuery queryWithClassName:@"User"];
//                AVObject *post = [query getObjectWithId:userArray[i]];
//                UIImageView *imageV = [UIImageView alloc] initWithFrame:<#(CGRect)#>
//            }
            
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [self.detailV layoutIfNeeded];
}

#pragma mark ---- UITextView代理方法
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

#pragma mark ---- UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ---- 屏幕触摸方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.detailV.bottomTextField resignFirstResponder];
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    self.detailV.bottomTextField.delegate = self;
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.detailV.bottomTextField.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
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
