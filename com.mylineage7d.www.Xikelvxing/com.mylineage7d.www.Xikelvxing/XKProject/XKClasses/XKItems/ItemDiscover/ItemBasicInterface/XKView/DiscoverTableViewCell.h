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
//@property (nonatomic,strong)UIImageView *main_pic; // 图片
@property (nonatomic,strong)UILabel *content; // 详情内容

@property (nonatomic, strong)UIButton *shareButton; // 分享按钮
@property (nonatomic, strong)UIButton *commentsButton; // 评论按钮
@property (nonatomic, strong)UIButton *heartButton; // 点赞按钮

@property (nonatomic,strong)DiscoverModel *disModel;
//@property (nonatomic,assign)CGFloat cellHeight; // Cell高度

//@property (nonatomic,strong)UILabel *num;
@property (nonatomic,assign)NSInteger index; // 标记
@property (nonatomic, copy)NSString *imageUrl;

@property (nonatomic, strong) YYAnimatedImageView *webImageView;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end
