//
//  WriteCommentView.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/25.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "WriteCommentView.h"

@implementation WriteCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    
    self.backgroundColor = TableView_Color;
    
    self.label = [UILabel new];
    self.textView = [UITextView new];
    
    [self addSubview:self.textView];
    [self addSubview:self.label];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(Left_Offset(-3), Top_Offset(64 + 7), Max_Width - 14, 17);
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.alpha = 0.3;
    self.label.backgroundColor = TableView_Color;
    self.label.text = @"说一说此刻的想法...";
    self.label.enabled = NO;
    [self.label sizeToFit];

    self.textView.frame = CGRectMake(Left_Offset(-7), Top_Offset(64), Max_Width - 6, Max_Height);
    self.textView.backgroundColor = TableView_Color;
    self.textView.font = [UIFont systemFontOfSize:17];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
