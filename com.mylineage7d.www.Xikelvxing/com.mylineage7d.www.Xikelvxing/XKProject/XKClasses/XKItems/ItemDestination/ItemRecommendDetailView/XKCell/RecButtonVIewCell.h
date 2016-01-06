//
//  RecButtonVIewCell.h
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecButtonVIewCell : UITableViewCell
@property (nonatomic,strong)UIButton *uploadPicturesButton;
@property (nonatomic,strong)UILabel *uploadPicturesLabel;
@property (nonatomic,strong)UIButton *writeCommentButton;
@property (nonatomic,strong)UILabel *writeCommentLabel;
@property (nonatomic,strong)UIButton *errorCorrectionButton;
@property (nonatomic,strong)UILabel *errorCorrectionLabel;
@property (nonatomic,strong)UIButton *shareButton;
@property (nonatomic,strong)UILabel *shareLabel;

@property (nonatomic,assign)CGFloat cellHeight; // Cell高度
@end
