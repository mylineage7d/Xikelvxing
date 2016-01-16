//
//  DiscoverDetailViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverDetailView.h"
#import "DiscoverModel.h"

typedef void(^LikeStatus)(BOOL status);
@interface DiscoverDetailViewController : UIViewController

@property (nonatomic, strong)DiscoverDetailView *detailV;
@property (nonatomic, strong)DiscoverModel *model;
@property (nonatomic, copy) LikeStatus block;
//@property (nonatomic, assign)BOOL likeStatus;

- (void)sendLikeStatus:(LikeStatus)block;
@end
