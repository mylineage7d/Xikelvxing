//
//  DestinationView.h
//  XikeTest
//
//  Created by lanou3g on 15/11/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationView : UIView
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImageView *cityV; // 城市图片
@property (nonatomic,strong)UIButton *destinationButton; // 目的地按钮
@property (nonatomic,strong)UIButton *searchButton; // 搜索按钮
@property (nonatomic,strong)UILabel *cityLabel; // 城市Label
@property (nonatomic,strong)NavBarLB *leftNavBarView;
@end
