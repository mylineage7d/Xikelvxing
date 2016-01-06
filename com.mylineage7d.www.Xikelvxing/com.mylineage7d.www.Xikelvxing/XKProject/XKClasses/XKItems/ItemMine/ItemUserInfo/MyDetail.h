//
//  MyDetail.h
//  XikeTest
//
//  Created by lanou3g on 15/12/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDetail : UIView
@property (nonatomic,strong)UIImageView *backIV;
@property (nonatomic,strong)UIImageView *userHeadIV;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *detailTitle;

@property (nonatomic,strong)UIView *weiboV;
@property (nonatomic,strong)UIImageView *weiboLogo;
@property (nonatomic,strong)UILabel *weiboLabel;

@property (nonatomic,strong)UIView *weChatV;
@property (nonatomic,strong)UIImageView *weChatLogo;
@property (nonatomic,strong)UILabel *weChatLabel;

@property (nonatomic,strong)UIView *talkV;
@property (nonatomic,strong)UIImageView *talkLogo;
@property (nonatomic,strong)UILabel *talkLabel;

@property (nonatomic,strong)UIView *shareAppV;
@property (nonatomic,strong)UIImageView *shareLogo;
@property (nonatomic,strong)UILabel *shareLabel;

@property (nonatomic,strong)UIButton *exitButton;
@end
