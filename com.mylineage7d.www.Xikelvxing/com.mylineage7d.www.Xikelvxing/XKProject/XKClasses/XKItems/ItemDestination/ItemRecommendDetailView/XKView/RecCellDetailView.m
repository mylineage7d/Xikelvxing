//
//  RecCellDetailView.m
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecCellDetailView.h"

@implementation RecCellDetailView

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
    
    self.main_pic = [UIImageView imageViewWithFrame:CGRectMake(0, 0, Image_Width, Image_Height) imageName:nil];
    self.main_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    self.headButton = [UIButton buttonWithFrame:CGRectMake(Max_Width - Button_Size / 2 - 40, CGRectGetMaxY(self.main_pic.frame) - Button_Size / 2, Button_Size, Button_Size) normalImageName:@"action_love_sketch"];
    self.headButton.layer.cornerRadius = Button_Size / 2;
    
    self.name = [UILabel labelWithFrame:CGRectMake(10, CGRectGetMaxY(self.headButton.frame), Max_Width - 20, 17) fontSize:17 lineBreak:YES];
    
    self.localname = [UILabel labelWithFrame:CGRectMake(self.name.frame.origin.x, CGRectGetMaxY(self.name.frame) + 3, self.name.frame.size.width, 17) fontSize:15 lineBreak:NO];
    
    self.introduce = [UILabel labelWithFrame:CGRectMake(self.name.frame.origin.x, CGRectGetMaxY(self.localname.frame) + 10, self.name.frame.size.width, 17) fontSize:16 lineBreak:NO];
    self.introduce.text = @"简介";
    self.introduce.alpha = 0.5;
    [Tools setLabelOrigin:self.introduce originX:self.name.frame.origin.x originY:CGRectGetMaxY(self.localname.frame) + 10];
    
    self.brief = [UILabel labelWithFrame:CGRectMake(10, CGRectGetMaxY(self.introduce.frame), self.name.frame.size.width, 50) fontSize:16 lineBreak:YES];
    
    self.leftNavBarView = [[NavBarLB alloc] initWithFrame:CGRectMake(0, 0, Max_Width / 4 * 3, 40)];
    
    [self addSubview:self.tableView];
    [self addSubview:self.headV];
    [self.headV addSubview:self.main_pic];
    [self.headV addSubview:self.headButton];
    [self.headV addSubview:self.name];
    [self.headV addSubview:self.localname];
    [self.headV addSubview:self.introduce];
    [self.headV addSubview:self.brief];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
