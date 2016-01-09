//
//  MyDetail.m
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MyDetail.h"

@implementation MyDetail

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    
    self.backgroundColor = TableView_Color;
    
    self.backIV = [[UIImageView alloc] init];
    self.userHeadIV = [[UIImageView alloc] init];
    self.userName = [UILabel new];
    self.title = [UILabel new];
    self.detailTitle = [UILabel new];
    
    self.weiboV = [UIView new];
    self.weiboLogo = [UIImageView new];
    self.weiboLabel = [UILabel new];
    
    self.weChatV = [UIView new];
    self.weChatLogo = [UIImageView new];
    self.weChatLabel = [UILabel new];
    
    self.talkV = [UIView new];
    self.talkLogo = [UIImageView new];
    self.talkLabel = [UILabel new];
    
    self.shareAppV = [UIView new];
    self.shareLogo = [UIImageView new];
    self.shareLabel = [UILabel new];
    
    self.exitButton = [UIButton new];
    
    [self addSubview:self.backIV];
    [self.backIV addSubview:self.userHeadIV];
    [self.backIV addSubview:self.userName];
    [self addSubview:self.title];
    [self addSubview:self.detailTitle];
    
    [self addSubview:self.weiboV];
    [self.weiboV addSubview:self.weiboLogo];
    [self.weiboV addSubview:self.weiboLabel];
    
    [self addSubview:self.weChatV];
    [self.weChatV addSubview:self.weChatLogo];
    [self.weChatV addSubview:self.weChatLabel];
    
    [self addSubview:self.talkV];
    [self.talkV addSubview:self.talkLogo];
    [self.talkV addSubview:self.talkLabel];
    
    [self addSubview:self.shareAppV];
    [self.shareAppV addSubview:self.shareLogo];
    [self.shareAppV addSubview:self.shareLabel];
    
    [self addSubview:self.exitButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backIV.frame = CGRectMake(0, 0, Image_Width, Image_Width / 2.09);
    self.backIV.image = [UIImage imageNamed:@"avatar_background_sketch"];
    
    self.userHeadIV.frame = CGRectMake(Left_Offset(20), self.backIV.frame.size.height - Botton_Offset(10) - Button_Size, Button_Size, Button_Size);
    self.userHeadIV.layer.masksToBounds = YES;
    self.userHeadIV.layer.cornerRadius = Button_Size / 2;
    
    self.userName.frame = CGRectMake(CGRectGetMaxX(self.userHeadIV.frame) + Left_Offset(10), self.userHeadIV.center.y - 17 / 2, 100, 17);
//    self.userName.text = @"他们不过将就_";
    [self.userName setTextColor:[UIColor whiteColor]];
    self.userName.font = [UIFont systemFontOfSize:17];
//    [self.userName sizeToFit];
//    self.userName.backgroundColor = [UIColor yellowColor];
    
    self.title.frame = CGRectMake(Left_Offset(20), CGRectGetMaxY(self.backIV.frame) + Top_Offset(20), Max_Width - 20, 17);
    self.title.text = @"来了,都是稀客";
    [Tools setLabelOrigin:self.title fontSize:17];
    
    self.detailTitle.frame = CGRectMake(self.title.frame.origin.x, CGRectGetMaxY(self.title.frame), Max_Width - 40, 17);
    self.detailTitle.text = @"稀客旅行,是一个面向国人的韩国旅游服务.我们专注于韩国旅游市场,以自由行为核心,全国挖掘当地旅游咨询服务,让更多的国人感受到来自韩国的魅力";
    [Tools setLabelOrigin:self.detailTitle fontSize:17];
    
    self.weiboV.frame = CGRectMake(self.title.frame.origin.x + Left_Offset(20), CGRectGetMaxY(self.detailTitle.frame) + Top_Offset(10), Max_Width - 60, 17);
    self.weiboLogo.frame = CGRectMake(0, 0, 17, 17);
    self.weiboLogo.image = [UIImage imageNamed:@"login_panel_weibo_sketch"];
    self.weiboLabel.frame = CGRectMake(CGRectGetMaxX(self.weiboLogo.frame) + 4, self.weiboLogo.frame.origin.y, Max_Width - 60, 17);
    self.weiboLabel.text = @"关注微博@稀客旅行";
    [Tools setLabelOrigin:self.weiboLabel fontSize:17];
    
    self.weChatV.frame = CGRectMake(self.title.frame.origin.x + Left_Offset(20), CGRectGetMaxY(self.weiboV.frame) + Top_Offset(10), Max_Width - 40, 17);
    self.weChatLogo.frame = CGRectMake(0, 0, 17, 17);
    self.weChatLogo.image = [UIImage imageNamed:@"login_panel_weixin_sketch"];
    self.weChatLabel.frame = CGRectMake(CGRectGetMaxX(self.weChatLogo.frame) + 4, self.weChatLogo.frame.origin.y, Max_Width - 60, 17);
    self.weChatLabel.text = @"关注公众号@稀客地图";
    [Tools setLabelOrigin:self.weChatLabel fontSize:17];
    
    self.talkV.frame = CGRectMake(self.detailTitle.frame.origin.x + Left_Offset(10), CGRectGetMaxY(self.weChatV.frame) + Top_Offset(30), Max_Width - 20, 17);
    self.talkLogo.frame = CGRectMake(0, 0, 17, 17);
    self.talkLogo.image = [UIImage imageNamed:@"icon_talk_sketch"];
    self.talkLabel.frame = CGRectMake(CGRectGetMaxX(self.talkLogo.frame) + 4, self.talkLogo.frame.origin.y, Max_Width - 60, 17);
    self.talkLabel.text = @"和我们聊聊";
    [Tools setLabelOrigin:self.talkLabel fontSize:17];
    
    self.shareAppV.frame = CGRectMake(self.detailTitle.frame.origin.x + Left_Offset(10), CGRectGetMaxY(self.talkV.frame) + Top_Offset(10), Max_Width - 40, 17);
    self.shareLogo.frame = CGRectMake(0, 0, 17, 17);
    self.shareLogo.image = [UIImage imageNamed:@"icon_share_sketch"];
    self.shareLabel.frame = CGRectMake(CGRectGetMaxX(self.weiboLogo.frame) + 4, self.weiboLogo.frame.origin.y, Max_Width - 60, 17);
    self.shareLabel.text = @"分享应用";
    [Tools setLabelOrigin:self.shareLabel fontSize:17];
    
    self.exitButton.frame = CGRectMake(Max_Width / 2 - 120 / 2, Max_Height - 49 - 40 - Botton_Offset(10), 120, 30);
    self.exitButton.center = CGPointMake(Max_Width / 2, Max_Height - 49 - 40 / 2 - Botton_Offset(10));
    [self.exitButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [self.exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.exitButton setFont:[UIFont systemFontOfSize:15]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
