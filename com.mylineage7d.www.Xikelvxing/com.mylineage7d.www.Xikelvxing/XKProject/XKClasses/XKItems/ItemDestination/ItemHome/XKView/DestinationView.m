//
//  DestinationView.m
//  XikeTest
//
//  Created by lanou3g on 15/11/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DestinationView.h"

@implementation DestinationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = TableView_Color;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, Max_Width, Max_Height + 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = TableView_Color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    self.cityV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Image_Width,Image_Height)];
    self.cityV.userInteractionEnabled = YES;
    
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(Image_Width / 2 - 100 / 2, Image_Height / 2 - 40 / 2, 100, 40)];
    self.cityLabel.font = [UIFont systemFontOfSize:19];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    self.cityLabel.textColor = [UIColor whiteColor];
//    self.cityLabel.backgroundColor = [UIColor blackColor];
    [self.cityLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    self.destinationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.destinationButton setTitle:@"目的地" forState:UIControlStateNormal];
    self.destinationButton.frame = CGRectMake(2, 0, 60, Lable_Size_Height);
    self.destinationButton.backgroundColor = [UIColor clearColor];
    
    
    self.leftNavBarView = [[NavBarLB alloc] initWithFrame:CGRectMake(0, 0, Max_Width / 4 * 3, 40)];
    self.leftNavBarView.navBarIV.image = [UIImage imageNamed:@"icon_mini_arrow_down_light_sketch"];
    self.leftNavBarView.navBarLabel.text = @"目的地";
    self.leftNavBarView.navBarLabel.textColor = [UIColor whiteColor];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchButton setImage:[UIImage imageNamed:@"icon_search_light_sketch"] forState:UIControlStateNormal];
    self.searchButton.frame = CGRectMake(Max_Width - 25, 5, 20, 20);
    self.searchButton.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_tableView];
    [self addSubview:self.cityV];
    [self.cityV addSubview:self.cityLabel];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
