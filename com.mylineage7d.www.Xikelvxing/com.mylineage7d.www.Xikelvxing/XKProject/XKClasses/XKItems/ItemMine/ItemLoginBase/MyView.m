//
//  MyView.m
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    
    self.backgroundColor = TableView_Color;
    
    self.xiIV = [UIImageView new];
    self.loginButton = [UIButton new];


    [self addSubview:self.xiIV];
    [self addSubview:self.loginButton];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.xiIV.frame = CGRectMake(Max_Width / 2 - 71 / 2, Max_Height / 2 - 82, 71, 82);
    self.xiIV.image = [UIImage imageNamed:@"unlogin_sketch"];
    
    self.loginButton.frame = CGRectMake(Max_Width / 2 - 150 / 2, CGRectGetMaxY(self.xiIV.frame), 150, 40);
    [self.loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.loginButton.alpha = 0.7;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
