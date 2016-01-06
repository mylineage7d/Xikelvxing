//
//  JXDataMethod.h
//  XikeTest
//
//  Created by lanou3g on 15/12/1.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXDataMethod : NSObject

#pragma mark ---- 解析Destination数据
+ (void)requestDataClassName:(NSString *)className whereKey:(NSString *)whereKey equalTo:(NSString *)equalTo block:(void(^)(NSArray *array))RequestBlock;

#pragma mark ---- 解析DiscoverModel
//+ (void)requestDataClassName:(NSString *)className block:(void(^)(NSArray *array))RequestBlock;

#pragma mark ---- 解析Recommend数据
+ (void)requestPlaceIdsArray:(NSArray *)placeIdsArray block:(void(^)(NSArray *array))RequestBlock;

#pragma mark ---- 解析DetialButton数据
+ (void)requestDataCity_id:(NSString *)city_id type:(NSString *)type sub_type:(NSString *)sub_type area:(NSString *)area sort:(NSString *)sort block:(void(^)(NSArray *array))RequestBlock;

#pragma mark ---- 解析DetialButton数据2
+ (void)requestData:(NSURL *)url block:(void(^)(NSArray *array))RequestBlock;
@end
