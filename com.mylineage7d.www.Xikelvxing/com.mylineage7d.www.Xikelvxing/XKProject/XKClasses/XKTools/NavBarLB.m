//
//  NavBarLB.m
//  XikeTest
//
//  Created by lanou3g on 15/12/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "NavBarLB.h"

@implementation NavBarLB

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.navBarIV = [UIImageView imageViewWithFrame:CGRectMake(0, (40 - 8) / 2, 15, 8) imageName:@"icon_mini_arrow_down_light_sketch"];
    self.navBarIV.userInteractionEnabled = YES;
    
    self.navBarLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.navBarIV.frame) + 5,(40 - 17) / 2, self.frame.size.width , 17) fontSize:17 lineBreak:NO];
    
    self.tapNavBar = [[UITapGestureRecognizer alloc] init];
    
    [self addSubview:self.navBarIV];
    [self addSubview:self.navBarLabel];
    [self addGestureRecognizer:self.tapNavBar];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
