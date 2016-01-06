//
//  selectView.m
//  XikeTest
//
//  Created by lanou3g on 15/11/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "selectView.h"

@implementation selectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    self.scrollV = [[UIScrollView alloc] initWithFrame:Main_Screen];
    self.scrollV.contentSize = CGSizeMake(Image_Width,Image_Height * 2);
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.bounces = NO;
    [self.scrollV setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    self.shouerIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Image_Width,Image_Height)];
    self.shouerIV.image = [UIImage imageNamed:@"city_cover_shouer_sketch"];
    self.shouerIV.userInteractionEnabled = YES;
    [self.shouerIV setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    self.jizhoudaoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shouerIV.frame),Image_Width,Image_Height)];
    self.jizhoudaoIV.image = [UIImage imageNamed:@"city_jizhoudao_sketch"];
    self.jizhoudaoIV.userInteractionEnabled = YES;
    
    self.shouerLabel = [[UILabel alloc] initWithFrame:CGRectMake(Max_Width / 2 - 100 / 2, Max_Width / 3 * 2 / 2 - 40 / 2, 100, 40)];
    self.shouerLabel.font = [UIFont systemFontOfSize:19];
    self.shouerLabel.textAlignment = NSTextAlignmentCenter;
    self.shouerLabel.textColor = [UIColor whiteColor];
    self.shouerLabel.text = @"首尔";
    [self.shouerLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    self.jizhoudaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(Max_Width / 2 - 100 / 2, Max_Width / 3 * 2 / 2 - 40 / 2, 100, 40)];
    self.jizhoudaoLabel.font = [UIFont systemFontOfSize:19];
    self.jizhoudaoLabel.textAlignment = NSTextAlignmentCenter;
    self.jizhoudaoLabel.textColor = [UIColor whiteColor];
    self.jizhoudaoLabel.text = @"济州岛";
    
    self.shouerTap = [[UITapGestureRecognizer alloc] init];
    self.jizhoudaoTap = [[UITapGestureRecognizer alloc] init];
    
    self.selectCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectCityButton setTitle:@"选择城市" forState:UIControlStateNormal];
    self.selectCityButton.frame = CGRectMake(2, 0, 120, Lable_Size_Height);
    self.selectCityButton.backgroundColor = [UIColor clearColor];
    [self.selectCityButton setTitleColor:[UIColor colorWithRed:27/255.0 green:27/255.0 blue:27/255.0 alpha:1] forState:UIControlStateNormal];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"icon_arrow_right_sketch"] forState:UIControlStateNormal];
    self.backButton.frame = CGRectMake(Max_Width - 25, 5, 20, 20);
    self.backButton.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.scrollV];
    [self.scrollV addSubview:self.shouerIV];
    [self.scrollV addSubview:self.jizhoudaoIV];
    [self.shouerIV addSubview:self.shouerLabel];
    [self.jizhoudaoIV addSubview:self.jizhoudaoLabel];
    [self.shouerIV addGestureRecognizer:self.shouerTap];
    [self.jizhoudaoIV addGestureRecognizer:self.jizhoudaoTap];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
