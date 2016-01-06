//
//  RecommendTableViewCell.h
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationModel.h"
@interface RecommendTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *imageUrl; // 图片
@property (nonatomic,strong)UILabel *title; // 大标题
@property (nonatomic,strong)UILabel *placeNum; // 小标题
@property (nonatomic,strong)UIImageView *heartImage;
@property (nonatomic,strong)UILabel *marks; // 点赞数
@property (nonatomic,strong)DestinationModel *destinationModel;
@property (nonatomic,assign)CGFloat cellHeight;
@end
