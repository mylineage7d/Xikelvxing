//
//  LoginView.m
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.backIV = [UIImageView new];
    self.xiIV = [UIImageView new];
    self.xiLabel = [UILabel new];
    self.selectLabel = [UILabel new];
    self.weChatButton = [UIButton new];
    self.qqButton = [UIButton new];
    self.weiboButton = [UIButton new];
    
    [self addSubview:self.backIV];
    [self.backIV addSubview:self.xiIV];
    [self.backIV addSubview:self.xiLabel];
    [self.backIV addSubview:self.selectLabel];
    [self.backIV addSubview:self.weChatButton];
    [self.backIV addSubview:self.qqButton];
    [self.backIV addSubview:self.weiboButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backIV.frame = Main_Screen;
    self.backIV.image = [UIImage imageNamed:@"login_background_sketch"];
    self.backIV.userInteractionEnabled = YES;
    
    self.xiIV.frame = CGRectMake(Max_Width / 2 - 71 / 2, Max_Height / 2 - 82, 71, 82);
    self.xiIV.image = [UIImage imageNamed:@"logo_login_sketch"];
    
    self.xiLabel.frame = CGRectMake(self.xiIV.frame.origin.x, CGRectGetMaxY(self.xiIV.frame), 200, 40);
    self.xiLabel.text = @"来了,都是稀客";
    [Tools setLabelCenter:self.xiLabel fontSize:17 originX:Max_Width / 2 originY:CGRectGetMaxY(self.xiIV.frame)];
    
    self.selectLabel.frame = CGRectMake(Max_Width - 100, 40, 100, 40);
    self.selectLabel.text = @"选择登录方式";
    self.selectLabel.alpha = 0.5;
    self.selectLabel.font = [UIFont systemFontOfSize:14];
    [self.selectLabel sizeToFit];
    self.selectLabel.center = CGPointMake(Max_Width / 2, Max_Height - 100 - self.selectLabel.frame.size.height);
    
    self.weChatButton.frame = CGRectMake(Max_Width / 2 - Button_Size * 1.5 - 40, CGRectGetMaxY(self.selectLabel.frame) + Top_Offset(0), Button_Size, Button_Size);
    self.weChatButton.layer.cornerRadius = Button_Size / 2;
    [self.weChatButton setImage:[UIImage imageNamed:@"sns_wechat_sketch"] forState:UIControlStateNormal];
    
    self.qqButton.frame = CGRectMake(Max_Width / 2 - Button_Size / 2, CGRectGetMaxY(self.selectLabel.frame) + Top_Offset(0), Button_Size, Button_Size);
    self.qqButton.layer.cornerRadius = Button_Size / 2;
    [self.qqButton setImage:[UIImage imageNamed:@"sns_qq_sketch"] forState:UIControlStateNormal];
    
    self.weiboButton.frame = CGRectMake(CGRectGetMaxX(self.qqButton.frame) + 40, CGRectGetMaxY(self.selectLabel.frame) + Top_Offset(0), Button_Size, Button_Size);
    self.weiboButton.layer.cornerRadius = Button_Size / 2;
    [self.weiboButton setImage:[UIImage imageNamed:@"sns_sina_weibo_sketch"] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
