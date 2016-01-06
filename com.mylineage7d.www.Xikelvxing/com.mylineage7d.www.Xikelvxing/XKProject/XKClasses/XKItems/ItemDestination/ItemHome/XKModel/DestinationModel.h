//
//  DestinationModel.h
//  XikeTest
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationModel : NSObject

@property (nonatomic,strong)NSString *imageUrl; // 图片
@property (nonatomic,strong)NSString *marks; // 点赞数
@property (nonatomic,strong)NSString *content; // 内容
@property (nonatomic,strong)NSString *title; // 标题
@property (nonatomic,strong)NSString *status; // 状态
@property (nonatomic,strong)NSString *cityId; // 城市
@property (nonatomic,strong)NSArray *placeIdsArray; // 旅行地id
@property (nonatomic,strong)NSString *visits;

@property (nonatomic,strong)NSString *objectId; // 标示符
@end
