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
@property (nonatomic ,strong) NSMutableArray *tagArray;
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
    
    self.tagArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction)];
    [self.detailV.main_pic addGestureRecognizer:tap];
    
    [self.detailV.heartButton addTarget:self action:@selector(heartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 点击图片方法
- (void)tapImageAction {
    PhotoViewController *photoVC = [PhotoViewController new];
    photoVC.imageArray = self.model.imageUrls;
    [self.navigationController pushViewController:photoVC animated:YES];
}

// 点赞方法
- (void)heartButtonAction:(UIButton *)sender {
    
    AVUser *user = [AVUser currentUser];
    NSLog(@"userId:%@",user.objectId);
    
    if (sender.selected == NO) {
        sender.selected = YES;
        [sender setImage:[UIImage imageNamed:@"action_love_fill_sketch"] forState:UIControlStateNormal];
        
        if (user != nil) {
            AVObject *post = [AVObject objectWithClassName:@"MomentLike"];
            [post setObject:self.model.objectId forKey:@"momentId"];
            [post setObject:user.objectId forKey:@"userId"];
            [post save];
            
            [self setDatas];
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"请先登录"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else {
        sender.selected = NO;
        [sender setImage:[UIImage imageNamed:@"action_love_sketch"] forState:UIControlStateNormal];
        
        AVQuery *query = [AVQuery queryWithClassName:@"MomentLike"];
        [query whereKey:@"userId" equalTo:user.objectId];
        [query whereKey:@"momentId" equalTo:self.model.objectId];
        [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
            [object deleteInBackground];
        }];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [self setDatas];
            NSInteger num = [[self.tagArray lastObject] integerValue];
            [[self.detailV.scrollV viewWithTag:num] removeFromSuperview];
//        });
    }
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
    
    AVUser *user = [AVUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:@"MomentLike"];
    [query whereKey:@"momentId" equalTo:self.model.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSLog(@"id:%@",self.model.objectId);
            
            NSMutableArray *userArray = [[NSMutableArray alloc] init];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            for (AVObject *ob in objects) {
                [array addObject:[ob objectForKey:@"userId"]];
            }
            
            NSMutableArray *array2 = [self compareNum:array];
//            NSLog(@"array:%@",array2);

            for (int i = (int)array2.count; i > 0; i--) {
                [userArray addObject:array2[i - 1]];
            }

//            NSLog(@"user:%@",userArray);
            
            self.detailV.scrollLikeV.contentSize = CGSizeMake((10 + Button_Size) * userArray.count, Button_Size);
   
            for (int i = 0; i < userArray.count; i++) {
                AVQuery *query = [AVQuery queryWithClassName:@"_User"];
                AVObject *post = [query getObjectWithId:userArray[i]];
                NSString *imageUrl = [post objectForKey:@"avatarUrl"];
                
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((10 + Button_Size) * i, 0, Button_Size, Button_Size)];
                imageV.layer.masksToBounds = YES;
                imageV.layer.cornerRadius = Button_Size / 2;
                imageV.tag = 200 + i;
                [self.tagArray addObject:[NSNumber numberWithInteger:imageV.tag]];
                imageV.backgroundColor = [UIColor colorWithRed:0.813 green:0.941 blue:0.630 alpha:1.000];
                [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
                
                [self.detailV.scrollLikeV addSubview:imageV];
                
                if (user != nil) {
                    if ([userArray[i] isEqualToString:user.objectId]) {
                        self.detailV.heartButton.selected = YES;
                        [self.detailV.heartButton setImage:[UIImage imageNamed:@"action_love_fill_sketch"] forState:UIControlStateNormal];
                    }
                }
            }
            
            
            
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [self.detailV layoutIfNeeded];
}

//比较是否相等
-(NSMutableArray *)compareNum:(NSMutableArray *)mArr
{
    NSInteger count = mArr.count;//重新定义了,count不会减一
    for (int j = 0; j < count - 1; j++)
    {
        for (int i = j; i < count - 1 - 1; i++)
        {
//            NSLog(@" %@  %@",[mArr objectAtIndex:j],[mArr objectAtIndex:i + 2]);
            NSString *a = [mArr objectAtIndex:j];
            NSString *b = [mArr objectAtIndex:i + 2];
            
            if ([a isEqualToString:b])
            {
                [mArr replaceObjectAtIndex:i + 2 withObject:@" "];
            }
        }
    }
    
    NSMutableArray *removeStrs1 = [NSMutableArray array];
    
    for (NSString *str in mArr) {
        if ([str isEqualToString:@" "]) {
            [removeStrs1 addObject:str];
        }
    }
    
    for (NSString *st in removeStrs1) {
        [mArr removeObject:st];
    }
    
    for (int j = 0; j < mArr.count - 1; j++) {
        
        NSString *a = [mArr objectAtIndex:j];
        NSString *b = [mArr objectAtIndex:j + 1];
        
        if ([a isEqualToString:b])
        {
            [mArr replaceObjectAtIndex:j + 1 withObject:@" "];
        }
    }
    
    NSMutableArray *removeStrs2 = [NSMutableArray array];
    
    for (NSString *str in mArr) {
        if ([str isEqualToString:@" "]) {
            [removeStrs2 addObject:str];
        }
    }
    
    for (NSString *st in removeStrs2) {
        [mArr removeObject:st];
    }
    
    return mArr;
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
