//
//  NewViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverView.h"
@interface NewViewController : UIViewController

@property (nonatomic,strong)DiscoverView *discoverV;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度

@end
