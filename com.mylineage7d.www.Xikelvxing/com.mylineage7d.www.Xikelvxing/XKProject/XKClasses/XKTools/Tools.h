//
//  Tools.h
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

#pragma mark --- 单例
+ (Tools *)shareTools;

#pragma mark --- 自适应高度
+ (void)setLabelHeight:(UILabel *)label text:(NSString *)string fontSize:(NSInteger )fontSize;

#pragma mark --- 计算Label的原点和高度(弃用)
+ (void)setLabelOrigin:(UILabel *)label text:(NSString *)string fontSize:(NSInteger )fontSize originX:(CGFloat)originX originY:(CGFloat)originY;

#pragma mark --- 计算Label高度改良版
+ (void)setLabelOrigin:(UILabel *)label fontSize:(NSInteger )fontSize;

#pragma mark --- 计算Label的原点(弃用)
+ (void)setLabelOrigin:(UILabel *)label originX:(CGFloat)originX originY:(CGFloat)originY;

#pragma mark --- 计算Label的中心点
+ (void)setLabelCenter:(UILabel *)label originX:(CGFloat)originX originY:(CGFloat)originY;

#pragma mark --- 计算Label的中心点和高度(弃用)
+ (void)setLabelCenter:(UILabel *)label text:(NSString *)string fontSize:(NSInteger )fontSize originX:(CGFloat)originX originY:(CGFloat)originY;

#pragma mark --- 计算Label的中心点和高度改良版
+ (void)setLabelCenter:(UILabel *)label fontSize:(NSInteger )fontSize originX:(CGFloat)originX originY:(CGFloat)originY;
@end
