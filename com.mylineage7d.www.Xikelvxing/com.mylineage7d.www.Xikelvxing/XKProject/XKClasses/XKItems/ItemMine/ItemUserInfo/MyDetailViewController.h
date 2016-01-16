//
//  MyDetailViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetail.h"
@interface MyDetailViewController : UIViewController
@property (nonatomic, strong) MyDetail *myDetailV;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userHead;

@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) AVUser *user;

@property (nonatomic, copy) NSString *sourceVC;
@end
