//
//  ButtonTableViewCell.h
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonTableViewCell : UITableViewCell

@property (nonatomic,strong)UIButton *cateButton; // 美食按钮
@property (nonatomic,strong)UIButton *shoppingButton; // 购物按钮
@property (nonatomic,strong)UIButton *scenicSpotsButton; // 景点按钮
@property (nonatomic,strong)UILabel *cateLabel;
@property (nonatomic,strong)UILabel *shoppingLabel;
@property (nonatomic,strong)UILabel *scenicSpotsLabel;
@property (nonatomic,strong)UILabel *bigLabel; // 大标题
@property (nonatomic,strong)UILabel *smallLabel; // 小标题
@property (nonatomic,assign)CGFloat cellHeight;
@end
