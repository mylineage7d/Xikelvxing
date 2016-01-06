//
//  DiscoverDetailView.h
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverDetailView : UIView

@property (nonatomic,strong)UIScrollView *scrollV;
@property (nonatomic,strong)UIImageView *headImage; // 用户头像
@property (nonatomic,strong)UILabel *nameLabel; // 用户名
@property (nonatomic,strong)UILabel *dateLabel; //日期
@property (nonatomic,strong)UIImageView *main_pic; // 图片
@property (nonatomic,strong)UILabel *content; // 详情内容
@property (nonatomic,strong)UIButton *heartButton; //收藏

@property (nonatomic,strong)UIView *bottomV;
//@property (nonatomic,strong)UITextView *bottomTextView;
@property (nonatomic,strong)UITextField *bottomTextField;
@property (nonatomic,strong)UIButton *bottomButton;
@end
