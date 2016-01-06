//
//  selectViewController.h
//  XikeTest
//
//  Created by lanou3g on 15/11/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "selectView.h"
@interface selectViewController : UIViewController

typedef void(^SendMessageBlock)(NSString *str);
@property (nonatomic,copy)SendMessageBlock block;

- (void)sendMessage:(SendMessageBlock)block;

@property (nonatomic,strong)selectView *selectV;

@end
