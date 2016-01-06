//
//  PhotoViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"
#import "DiscoverModel.h"
@interface PhotoViewController : UIViewController
@property (nonatomic,strong)PhotoView *photoV;
@property (nonatomic,strong)DiscoverModel *model;
@property (nonatomic,strong)NSArray *imageArray;
@end
