//
//  HotViewController.h
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/23.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverView.h"
@interface HotViewController : UIViewController
@property (nonatomic,strong)DiscoverView *discoverV;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度
@end
