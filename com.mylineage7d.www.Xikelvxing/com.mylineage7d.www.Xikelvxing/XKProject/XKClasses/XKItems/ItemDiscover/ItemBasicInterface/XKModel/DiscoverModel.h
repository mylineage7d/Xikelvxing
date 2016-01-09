//
//  DiscoverModel.h
//  XikeTest
//
//  Created by lanou3g on 15/12/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DiscoverModel : NSObject
@property (nonatomic,copy)NSString *address; // 地址
@property (nonatomic,strong)NSString *content; // 内容
@property (nonatomic,strong)NSString *comments; // 评论人数
@property (nonatomic,strong)NSString *likes; // 喜欢
@property (nonatomic,strong)NSString *isHot; // 热门
@property (nonatomic,strong)NSString *userId; // 用户

@property (nonatomic,strong)NSString *seq; //
@property (nonatomic,strong)NSArray *imageUrls; // 图片
@property (nonatomic,strong)AVGeoPoint *location; // 坐标
@property (nonatomic,strong)NSString *enable; //
@property (nonatomic,strong)NSString *createdAt; // 创建时间
@property (nonatomic,strong)NSString *updatedAt;
@property (nonatomic, strong)NSString *objectId;

@property (nonatomic,strong)NSString *username; // 用户名
@property (nonatomic,strong)NSString *avatarUrl; // 用户头像

@property (nonatomic, copy) NSString *cellHeight;
@end
