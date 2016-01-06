//
//  RecommendDetailCell.h
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface RecommendDetailCell : UITableViewCell
@property (nonatomic,strong)UILabel *nameNumberLabel; // 标题数
@property (nonatomic,strong)UILabel *nameLabel; // 标题
@property (nonatomic,strong)UIImageView *main_pic; // 图片
@property (nonatomic,strong)UIImageView *addressImage; // 地址图
@property (nonatomic,strong)UILabel *addressLabel; // 地址
@property (nonatomic,strong)UILabel *briefLabel; // 详情内容

@property (nonatomic, strong)UIButton *shareButton; // 分享按钮
@property (nonatomic, strong)UIButton *commentsButton; // 评论按钮
@property (nonatomic, strong)UIButton *heartButton; // 点赞按钮

@property (nonatomic,strong)RecommendModel *recommendModel;
@property (nonatomic,assign)NSInteger index; // 标记
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度

@end
