//
//  RecommendViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendView.h"
#import "DestinationModel.h"
#import "RecommendModel.h"
@interface RecommendViewController : UIViewController
@property (nonatomic,strong)RecommendView *recommendV;
@property (nonatomic,strong)DestinationModel *desModel;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)RecommendModel *reModel;
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度
@end
