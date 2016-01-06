//
//  RecCellDetailView.h
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecCellDetailView : UIView
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIView *headV;
@property (nonatomic,strong)UIImageView *main_pic;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *brief;
@property (nonatomic,strong)UIButton *headButton;
@property (nonatomic,strong)UILabel *localname;
@property (nonatomic,strong)UILabel *introduce;

@property (nonatomic,strong)NavBarLB *leftNavBarView;

@end
