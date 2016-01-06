//
//  RecommendView.h
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationModel.h"
@interface RecommendView : UIView
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIView *headV;
@property (nonatomic,strong)UIImageView *imageUrl;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UIWebView *contentWV;

@property (nonatomic,strong)UIButton *headButton;
@property (nonatomic,strong)DestinationModel *model;
@property (nonatomic,strong)NavBarLB *leftNavBarView;

@end
