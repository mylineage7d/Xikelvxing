//
//  RecCommentCell.h
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/26.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecCommentCell : UITableViewCell
@property (nonatomic, strong)UIImageView *headImage; // 用户头像
@property (nonatomic, strong)UILabel *nameLabel; // 用户名
@property (nonatomic, strong)UILabel *dateLabel; //日期
@property (nonatomic, strong)UILabel *commentLabel; // 评论
@property (nonatomic, strong)AVObject *post;
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度
@end
