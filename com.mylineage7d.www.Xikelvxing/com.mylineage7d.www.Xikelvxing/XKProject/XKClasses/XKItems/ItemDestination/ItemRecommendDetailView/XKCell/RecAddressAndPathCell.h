//
//  RecAddressAndPathCell.h
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface RecAddressAndPathCell : UITableViewCell

@property (nonatomic,strong)RecommendModel *model;
@property (nonatomic,strong)UILabel *addressTitle;
@property (nonatomic,strong)UILabel *address;
@property (nonatomic,strong)UILabel *travelTitle;
@property (nonatomic,strong)UILabel *travel;
@property (nonatomic,strong)UIImageView *map;
@property (nonatomic,strong)UILabel *phoneTitle;
@property (nonatomic,strong)UILabel *phone;
@property (nonatomic,strong)UILabel *openinghoursTitle;
@property (nonatomic,strong)UILabel *openinghours;
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度

@end
