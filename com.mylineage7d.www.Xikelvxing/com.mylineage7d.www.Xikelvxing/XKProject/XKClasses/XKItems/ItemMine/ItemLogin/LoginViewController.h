//
//  LoginViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
@interface LoginViewController : UIViewController

@property (nonatomic,strong)LoginView *loginV;
@property (nonatomic,assign)NSInteger state; // 判断状态
@end
