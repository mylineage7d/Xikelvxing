//
//  DiscoverDetailView.m
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//
#define NameFontSize 17
#define BriefFontSize 16
#define SmallFontSize 14

#import "DiscoverDetailView.h"

@implementation DiscoverDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = TableView_Color;
    
    self.scrollV = [UIScrollView new];
    self.headImage = [[UIImageView alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.dateLabel = [UILabel new];
    self.main_pic = [[UIImageView alloc] init];
    self.content = [[UILabel alloc] init];
    self.heartButton = [UIButton new];
    self.bottomV = [UIView new];
    self.bottomTextField = [UITextField new];
//    self.bottomTextView = [UITextView new];
    self.bottomButton = [UIButton new];
    
    [self addSubview:self.scrollV];
    [self.scrollV addSubview:self.headImage];
    [self.scrollV addSubview:self.nameLabel];
    [self.scrollV addSubview:self.dateLabel];
    [self.scrollV addSubview:self.main_pic];
    [self.scrollV addSubview:self.content];
    [self.scrollV addSubview:self.heartButton];
    [self addSubview:self.bottomV];
    [self addSubview:self.bottomTextField];
//    [self addSubview:self.bottomTextView];
    [self addSubview:self.bottomButton];
    
    [self bringSubviewToFront:self.bottomTextField];
//    [self bringSubviewToFront:self.bottomTextView];
    [self bringSubviewToFront:self.bottomButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollV.frame = CGRectMake(0, 0, Max_Width, Max_Height - 49);
//    self.scrollV.userInteractionEnabled = YES;
    
    self.headImage.frame = CGRectMake(Left_Offset(0), Top_Offset(0), Button_Size, Button_Size);
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width / 2;
    self.headImage.layer.masksToBounds = YES;
//    self.headImage.image = [UIImage imageNamed:@"logo_512_sketch"];
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame), self.headImage.frame.origin.y, Max_Width - 30, NameFontSize);
//    self.nameLabel.text = @"稀客旅行";
//    self.nameLabel.backgroundColor = [UIColor yellowColor];
    [Tools setLabelOrigin:self.nameLabel text:self.nameLabel.text fontSize:NameFontSize originX:CGRectGetMaxX(self.headImage.frame) + 5 originY:(self.headImage.frame.size.height - self.nameLabel.frame.size.height) / 2 + 10];
    
    self.dateLabel.frame = CGRectMake(Max_Width / 4 * 3, self.nameLabel.frame.origin.y, 50, self.nameLabel.frame.size.height);
    //    [Tools setLabelOrigin:self.dateLabel text:self.dateLabel.text fontSize:NameFontSize originX:Max_Width - self.dateLabel.frame.size.width - Right_Offset(0) originY:self.nameLabel.frame.origin.y];
    
    self.main_pic.frame = CGRectMake(0, CGRectGetMaxY(self.headImage.frame) + 10, Image_Width, Image_Height);
//    self.main_pic.backgroundColor = [UIColor cyanColor];
    self.main_pic.userInteractionEnabled = YES;
    self.main_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    self.heartButton.frame = CGRectMake(Max_Width - Button_Size / 2 - 40, CGRectGetMaxY(self.main_pic.frame) - Button_Size / 2, Button_Size, Button_Size);
    [self.heartButton setImage:[UIImage imageNamed:@"action_love_sketch"] forState:UIControlStateNormal];
    self.heartButton.layer.cornerRadius = Button_Size / 2;
    
    self.content.frame = CGRectMake(self.headImage.frame.origin.x, CGRectGetMaxY(self.heartButton.frame) + Top_Offset(0), Max_Width - 20, 16);
    self.content.font = [UIFont systemFontOfSize:BriefFontSize];
    self.content.textAlignment = NSTextAlignmentCenter;
    [Tools setLabelCenter:self.content text:self.content.text fontSize:BriefFontSize originX:self.main_pic.center.x originY:CGRectGetMaxY(self.heartButton.frame)];

    self.bottomV.frame = CGRectMake(0, Max_Height - 40 - 64, Max_Width, 40);
    self.bottomV.backgroundColor = [UIColor whiteColor];
    
    self.bottomTextField.frame = CGRectMake(Left_Offset(0), Max_Height - 40 - 64 + 3, (Max_Width - 25) / 5 * 4, 30);
    self.bottomTextField.placeholder = @"来评论一句吧";
    self.bottomTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.bottomTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.bottomTextField.font = [UIFont systemFontOfSize:17];
    
//    self.bottomTextView.frame = CGRectMake(Left_Offset(0), Max_Height - 40 - 64 + 3, (Max_Width - 25) / 5 * 4, 30);
//    self.bottomTextView.font = [UIFont systemFontOfSize:17];
    
    self.bottomButton.frame = CGRectMake(Max_Width - (Max_Width - 25) / 5 - Right_Offset(0), Max_Height - 40 - 64 + 5, (Max_Width - 25) / 5, 30);
    [self.bottomButton setTitle:@"评论" forState:UIControlStateNormal];
    self.bottomButton.backgroundColor = [UIColor colorWithRed:33/255.0 green:150/255.0 blue:243/255.0 alpha:1];
    
    if (CGRectGetMaxY(self.content.frame) > Max_Width) {
        self.scrollV.contentSize  = CGSizeMake(Max_Width, CGRectGetMaxY(self.content.frame));
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
