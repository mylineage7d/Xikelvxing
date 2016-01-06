//
//  PhotoView.m
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    
    self.backgroundColor = [UIColor redColor];
    
    self.scrollV = [UIScrollView new];
    self.pageLabel = [UILabel new];
    
    [self addSubview:self.scrollV];
    [self addSubview:self.pageLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollV.frame = CGRectMake(0, 0, Max_Width, Max_Height + 64 + 49);
    self.scrollV.backgroundColor = [UIColor whiteColor];
    self.scrollV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollV.pagingEnabled = YES;
    self.scrollV.userInteractionEnabled = YES;
    self.scrollV.showsHorizontalScrollIndicator = NO;
    
    self.pageLabel.frame = CGRectMake(0, Max_Height - 35, Max_Width, 35);
    self.pageLabel.textAlignment = NSTextAlignmentCenter;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
