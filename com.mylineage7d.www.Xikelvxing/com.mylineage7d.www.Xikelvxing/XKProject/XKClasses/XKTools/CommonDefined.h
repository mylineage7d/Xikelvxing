//
//  CommonDefined.h
//  XikeTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#ifndef CommonDefined_h
#define CommonDefined_h

// 单例
#define MRY_ShareTools [Tools shareTools]

// 重用标示
#define cButtonTableView_Cell @"ButtonTableView_Cell"
#define cRecommendTableView_Cell @"RecommendTableView_Cell"
#define cRecommendDetail_Cell @"RecommendDetail_Cell"
#define cRecButtonView_Cell @"RecButtonView_Cell"
#define cRecAddressAndPath_Cell @"RecAddressAndPath_Cell"
#define cDetailButton_Cell @"DetailButton_Cell"
#define cDiscover_Cell @"Discover_Cell"
#define cDiscoverViewTableView_Cell @"DiscoverViewTableView_Cell"
#define cRecComment_Cell @"RecComment_Cell"
#define cErrorCorrection_Cell @"ErrorCorrection_Cell"
#define cUploadViewController_Cell @"UploadViewController_Cell"
#define cAddCollectionView_Cell @"AddCollectionView_Cell"
#define cUploadAddViewController_Cell @"UploadAddViewController_Cell"

// 屏幕长宽
#define Main_Screen [UIScreen mainScreen].bounds
#define Max_Width [UIScreen mainScreen].bounds.size.width
#define Max_Height [UIScreen mainScreen].bounds.size.height

// ButtonTableViewCell 大小
#define Button_Size ([UIScreen mainScreen].bounds.size.width / 8)
#define Lable_Size_Height 30

// 图片长宽
#define Image_Width [UIScreen mainScreen].bounds.size.width
#define Image_Height ([UIScreen mainScreen].bounds.size.width / 3 * 2)

// NavBar
#define NAVBAR_CHANGE_POINT ([UIScreen mainScreen].bounds.size.width / 3 * 2) - 84 * 2

// tableView颜色
#define TableView_Color [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]

// NavBar颜色
#define NavBar_Color [UIColor colorWithRed:0/255.0 green:182/255.0 blue:250/255.0 alpha:1]

// 基本约束
#define Top_Offset(...) (0 + ((__VA_ARGS__)))
#define Left_Offset(...) (0 + ((__VA_ARGS__)))
#define Botton_Offset(...) (0 + ((__VA_ARGS__)))
#define Right_Offset(...) (0 + ((__VA_ARGS__)))


#endif /* CommonDefined_h */
