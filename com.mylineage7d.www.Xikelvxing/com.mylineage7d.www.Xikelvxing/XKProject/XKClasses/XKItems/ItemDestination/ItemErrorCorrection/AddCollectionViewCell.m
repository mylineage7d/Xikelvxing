//
//  AddCollectionViewCell.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/28.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "AddCollectionViewCell.h"

@implementation AddCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 80, 80);
    [self.button setImage:[UIImage imageNamed:@"post_add_pic"] forState:UIControlStateNormal];
    [self addSubview:self.button];
}
@end
