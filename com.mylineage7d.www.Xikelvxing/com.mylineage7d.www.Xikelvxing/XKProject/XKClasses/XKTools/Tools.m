//
//  Tools.m
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "Tools.h"

@implementation Tools

#pragma mark --- 单例
static Tools *tool = nil;
+ (Tools *)shareTools{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

#pragma mark --- 自适应高度
+ (void)setLabelHeight:(UILabel *)label text:(NSString *)string fontSize:(NSInteger )fontSize{
//    label.backgroundColor = [UIColor cyanColor];
    label.numberOfLines = 0;
    CGRect rectNew = label.frame;
    // 定下宽度,计算高度
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, 1000);
    
    // 限定字体的大小
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    rectNew.size.height = rect.size.height;
    label.frame = rectNew;
}

#pragma mark --- 计算Label的原点(弃用)
+ (void)setLabelOrigin:(UILabel *)label originX:(CGFloat)originX originY:(CGFloat)originY{
//    label.backgroundColor = [UIColor yellowColor];
    [label sizeToFit];
    CGRect rect = label.frame;
    rect.origin = CGPointMake(originX, originY);
    label.frame= rect;
}

#pragma mark --- 计算Label的原点和高度(弃用)
+ (void)setLabelOrigin:(UILabel *)label text:(NSString *)string fontSize:(NSInteger )fontSize originX:(CGFloat)originX originY:(CGFloat)originY{
    label.numberOfLines = 0;
    [label sizeToFit];
    CGRect rect = label.frame;
    rect.origin = CGPointMake(originX, originY);
    label.frame= rect;
    [self setLabelHeight:label text:string fontSize:fontSize];
}

#pragma mark --- 计算Label高度改良版
+ (void)setLabelOrigin:(UILabel *)label fontSize:(NSInteger )fontSize{
    label.numberOfLines = 0;
    [label sizeToFit];
    CGRect rect = label.frame;
    label.frame= rect;
    [self setLabelHeight:label text:label.text fontSize:fontSize];
}

#pragma mark --- 计算Label的中心点
+ (void)setLabelCenter:(UILabel *)label originX:(CGFloat)originX originY:(CGFloat)originY{
    label.center = CGPointMake(originX, originY);
}

#pragma mark --- 计算Label的中心点和高度(弃用)
+ (void)setLabelCenter:(UILabel *)label text:(NSString *)string fontSize:(NSInteger )fontSize originX:(CGFloat)originX originY:(CGFloat)originY{
    label.numberOfLines = 0;
    [label sizeToFit];
    [self setLabelHeight:label text:string fontSize:fontSize];
    label.center = CGPointMake(originX, originY + label.frame.size.height / 2 + Top_Offset(0));
}

#pragma mark --- 计算Label的中心点和高度改良版
+ (void)setLabelCenter:(UILabel *)label fontSize:(NSInteger )fontSize originX:(CGFloat)originX originY:(CGFloat)originY{
    label.numberOfLines = 0;
    [label sizeToFit];
    [self setLabelHeight:label text:label.text fontSize:fontSize];
    label.center = CGPointMake(originX, originY + label.frame.size.height / 2 + Top_Offset(0));
}

@end
