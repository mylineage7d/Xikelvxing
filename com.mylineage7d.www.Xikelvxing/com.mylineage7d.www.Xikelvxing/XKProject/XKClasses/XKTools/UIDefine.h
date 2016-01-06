//
//  UIDefine.h
//  Douban
//
//  Created by qintao on 14/8/15.
//  Copyright (c) 2014年 覃涛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIButton (Create)

+ (UIButton *)buttonWithFrame:(CGRect)frame
              normalImageName:(NSString *)normalName;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle;

+ (UIButton *)buttonWithFrame:(CGRect)frame
              normalImageName:(NSString *)normalName
                       addTarget:(id)target
                       action:(SEL)action;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle
                       addTarget:(id)target
                       action:(SEL)action;

@end

@interface UILabel (Create)

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text;

+ (UILabel *)labelWithFrame:(CGRect)frame
                   fontSize:(CGFloat)size
                  lineBreak:(BOOL)isBreak;


@end

@interface UIImageView (Create)

+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;


@end

@interface UITextField (Create)

+ (UITextField *)textFieldWithFrame:(CGRect)frame;

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder
                             secure:(BOOL)isSecure;


@end


