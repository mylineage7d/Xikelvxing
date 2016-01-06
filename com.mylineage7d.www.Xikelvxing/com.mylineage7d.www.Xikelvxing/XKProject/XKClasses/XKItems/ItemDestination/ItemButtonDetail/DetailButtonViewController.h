//
//  DetailButtonViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailButtonView.h"
#import "RecommendModel.h"
@interface DetailButtonViewController : UIViewController
@property (nonatomic,strong)DetailButtonView *detailButtonV;
@property (nonatomic,strong)NSArray *categoryCateArray; // 美食类别
@property (nonatomic,strong)NSArray *categoryShoppingArray; // 购物类别
@property (nonatomic,strong)NSArray *categoryScenicSpotsArray; // 景点类别
@property (nonatomic,strong)NSArray *areaShouerArray; // 首尔区域
@property (nonatomic,strong)NSArray *areaJizhoudaoArray; // 济州岛区域
@property (nonatomic,strong)NSArray *sortArray; // 排序

@property (nonatomic,strong)NSString *city_id; // 城市
@property (nonatomic,strong)NSString *type; // 类型
@property (nonatomic,strong)RecommendModel *model;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSString *navBarTitle;

@end
