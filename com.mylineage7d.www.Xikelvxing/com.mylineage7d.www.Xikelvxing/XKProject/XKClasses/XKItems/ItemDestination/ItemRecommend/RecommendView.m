//
//  RecommendView.m
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendView.h"

@implementation RecommendView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Max_Width, Max_Height + 49) style:UITableViewStyleGrouped];
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Max_Width, Max_Height)];
    self.headV.backgroundColor = [UIColor whiteColor];
    
    self.imageUrl = [UIImageView imageViewWithFrame:CGRectMake(0, 0, Image_Width, Image_Height) imageName:nil];
    
    self.headButton = [UIButton buttonWithFrame:CGRectMake(Max_Width - Button_Size / 2 - 40, CGRectGetMaxY(self.imageUrl.frame) - Button_Size / 2, Button_Size, Button_Size) normalImageName:@"action_love_sketch"];
    self.headButton.layer.cornerRadius = Button_Size / 2;
    
    self.title = [UILabel labelWithFrame:CGRectMake(10, CGRectGetMaxY(self.headButton.frame), Max_Width - 20, 0) fontSize:17 lineBreak:YES];
    
    self.content = [UILabel labelWithFrame:CGRectMake(10, CGRectGetMaxY(self.title.frame) + Top_Offset(10), self.title.frame.size.width, 100) fontSize:16 lineBreak:YES];
    
    self.leftNavBarView = [[NavBarLB alloc] initWithFrame:CGRectMake(0, 0, Max_Width / 3, 30)];
    self.leftNavBarView.navBarLabel.text = @"推荐攻略";
//    self.leftNavBarView.backgroundColor = [UIColor yellowColor];
    
//    self.contentWV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, 50, 40)];
//    [self addSubview:self.headV];
    
    
    [self addSubview:self.tableView];
    [self addSubview:self.headV];
    [self.headV addSubview:self.imageUrl];
    [self.headV addSubview:self.headButton];
    [self.headV addSubview:self.content];
    [self.headV addSubview:self.title];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
