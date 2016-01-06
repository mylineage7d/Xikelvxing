//
//  WMMenuView.h
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMMenuView;
@class WMMenuItem;
typedef enum {
    WMMenuViewStyleDefault,     // 默认
    WMMenuViewStyleLine,        // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
    WMMenuViewStyleFoold,       // 涌入效果 (填充)
    WMMenuViewStyleFooldHollow, // 涌入效果 (空心的)
} WMMenuViewStyle;

@protocol WMMenuViewDelegate <NSObject>
@optional
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index;
@end

@interface WMMenuView : UIView
@property (nonatomic, assign) CGFloat progressHeight;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) WMMenuViewStyle style;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, weak) id<WMMenuViewDelegate> delegate;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic,strong)UIButton *cameraButton;
@property (nonatomic, weak) UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame buttonItems:(NSArray *)items backgroundColor:(UIColor *)bgColor norSize:(CGFloat)norSize selSize:(CGFloat)selSize norColor:(UIColor *)norColor selColor:(UIColor *)selColor;
- (void)slideMenuAtProgress:(CGFloat)progress;
- (void)selectItemAtIndex:(NSInteger)index;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com