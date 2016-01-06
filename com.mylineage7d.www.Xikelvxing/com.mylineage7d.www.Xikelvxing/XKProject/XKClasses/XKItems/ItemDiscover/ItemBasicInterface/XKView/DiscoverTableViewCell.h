//
//  DiscoverTableViewCell.h
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/23.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"
@interface DiscoverTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImage; // 用户头像
@property (nonatomic,strong)UILabel *nameLabel; // 用户名
@property (nonatomic,strong)UILabel *dateLabel; //日期
@property (nonatomic,strong)UIImageView *main_pic; // 图片
@property (nonatomic,strong)UILabel *content; // 详情内容

//@property (nonatomic,strong)UIView *shareV; // 分享按钮
//@property (nonatomic,strong)UIImageView *shareIV; // 分享按钮
//@property (nonatomic,strong)UILabel *shareLabel; //分享数
//
//@property (nonatomic,strong)UIView *commentsV; // 评论按钮
//@property (nonatomic,strong)UIImageView *commentsIV; // 评论按钮
//@property (nonatomic,strong)UILabel *commentsLabel; // 评论人数
//
//@property (nonatomic,strong)UIView *heartV; // 点赞按钮
//@property (nonatomic,strong)UIImageView *heartIV; // 点赞按钮
//@property (nonatomic,strong)UILabel *heartLabel; // 点赞

@property (nonatomic, strong)UIButton *shareButton; // 分享按钮
@property (nonatomic, strong)UIButton *commentsButton; // 评论按钮
@property (nonatomic, strong)UIButton *heartButton; // 点赞按钮

@property (nonatomic,strong)DiscoverModel *disModel;
//@property (nonatomic,assign)CGFloat cellHeight; // Cell高度

//@property (nonatomic,strong)UILabel *num;
@property (nonatomic,assign)NSInteger index; // 标记
@property (nonatomic,strong)NSString *imageUrl;

+(CGFloat)cellHeight:(DiscoverModel *)model;

@end
