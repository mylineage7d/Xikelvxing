//
//  RecCellDetailViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecCellDetailView.h"
#import "RecommendModel.h"
@interface RecCellDetailViewController : UIViewController
@property (nonatomic,strong)RecCellDetailView *cellDetailV;
@property (nonatomic,strong)RecommendModel *recModel;
@property (nonatomic,assign)CGFloat cellHeight1; //Cell高度
@property (nonatomic,assign)CGFloat cellHeight2; //Cell高度
@property (nonatomic,assign)CGFloat cellHeight3; //Cell高度
@property (nonatomic,strong)NSString *navBarTitle;
@property (nonatomic, strong)NSString *esPlaceId;
@end
