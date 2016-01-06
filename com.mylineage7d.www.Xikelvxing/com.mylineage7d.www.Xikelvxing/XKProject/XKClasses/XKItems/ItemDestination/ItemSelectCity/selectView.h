//
//  selectView.h
//  XikeTest
//
//  Created by lanou3g on 15/11/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectView : UIView

@property (nonatomic,strong)UIScrollView *scrollV;
@property (nonatomic,strong)UIImageView *shouerIV;
@property (nonatomic,strong)UIImageView *jizhoudaoIV;
@property (nonatomic,strong)UILabel *shouerLabel;
@property (nonatomic,strong)UILabel *jizhoudaoLabel;
@property (nonatomic,strong)UITapGestureRecognizer *shouerTap;
@property (nonatomic,strong)UITapGestureRecognizer *jizhoudaoTap;
@property (nonatomic,strong)UIButton *selectCityButton;
@property (nonatomic,strong)UIButton *backButton;

@end
