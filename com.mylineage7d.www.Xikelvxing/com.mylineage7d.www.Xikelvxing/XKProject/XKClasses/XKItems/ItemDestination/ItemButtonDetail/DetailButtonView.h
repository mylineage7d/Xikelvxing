//
//  DetailButtonView.h
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOPDropDownMenu.h"
@interface DetailButtonView : UIView

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)DOPDropDownMenu *menu;
@property (nonatomic,strong)NavBarLB *leftNavBarView;

@end
