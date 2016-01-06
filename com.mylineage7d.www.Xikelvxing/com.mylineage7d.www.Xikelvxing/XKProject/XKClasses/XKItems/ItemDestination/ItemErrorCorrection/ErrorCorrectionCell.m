//
//  ErrorCorrectionCell.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/26.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "ErrorCorrectionCell.h"

@implementation ErrorCorrectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.imV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.imV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imV];
}
@end
