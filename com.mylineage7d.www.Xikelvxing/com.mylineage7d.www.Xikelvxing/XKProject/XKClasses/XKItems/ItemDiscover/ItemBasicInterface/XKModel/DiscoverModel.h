//
//  DiscoverModel.h
//  XikeTest
//
//  Created by lanou3g on 15/12/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DiscoverModel : NSObject
@property (nonatomic, copy)NSString *address; // 地址
@property (nonatomic, copy)NSString *content; // 内容
@property (nonatomic, copy)NSString *comments; // 评论人数
@property (nonatomic, copy)NSString *likes; // 喜欢
@property (nonatomic, copy)NSString *isHot; // 热门
@property (nonatomic, copy)NSString *userId; // 用户

@property (nonatomic, copy)NSString *seq; //
@property (nonatomic, copy)NSArray *imageUrls; // 图片
@property (nonatomic, strong)AVGeoPoint *location; // 坐标
@property (nonatomic, copy)NSString *enable; //
@property (nonatomic, copy)NSString *createdAt; // 创建时间
@property (nonatomic, copy)NSString *updatedAt;
@property (nonatomic, copy)NSString *objectId;

@property (nonatomic, copy)NSString *username; // 用户名
@property (nonatomic, copy)NSString *avatarUrl; // 用户头像

@property (nonatomic, copy) NSString *cellHeight;
@property (nonatomic, assign)BOOL likeVStatus; // 点赞状态
@end
