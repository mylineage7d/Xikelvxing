//
//  DetailButtonView.m
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DetailButtonView.h"

@implementation DetailButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, Max_Width, Max_Height) style:UITableViewStylePlain];
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    [menu selectDefalutIndexPath];
    self.menu = menu;
    
    self.leftNavBarView = [[NavBarLB alloc] initWithFrame:CGRectMake(0, 0, Max_Width / 5, 30)];
//    self.leftNavBarView.backgroundColor = [UIColor yellowColor];
    
    [self addSubview:self.tableView];
    [self addSubview:menu];
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
