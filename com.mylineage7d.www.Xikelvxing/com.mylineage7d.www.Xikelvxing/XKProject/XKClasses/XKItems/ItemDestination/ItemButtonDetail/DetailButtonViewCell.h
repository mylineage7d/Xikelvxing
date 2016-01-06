//
//  DetailButtonViewCell.h
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface DetailButtonViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *main_pic; // 图片
@property (nonatomic,strong)UILabel *name; // 大标题
@property (nonatomic,strong)UILabel *localname; // 当地名称
@property (nonatomic,strong)UILabel *type; // 分类
@property (nonatomic,strong)RecommendModel *model;
@property (nonatomic,assign)CGFloat cellHeight;
@end
