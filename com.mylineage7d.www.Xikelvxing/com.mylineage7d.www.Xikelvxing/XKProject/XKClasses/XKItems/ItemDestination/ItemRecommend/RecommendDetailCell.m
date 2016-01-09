//
//  RecommendDetailCell.m
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#define NameFontSize 17
#define BriefFontSize 16
#define SmallFontSize 14

#import "RecommendDetailCell.h"
@implementation RecommendDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.nameNumberLabel = [UILabel new];
    self.nameLabel = [UILabel new];
    self.main_pic = [UIImageView new];
    self.addressImage = [UIImageView new];
    self.addressLabel = [UILabel new];
    self.briefLabel = [UILabel new];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:self.nameNumberLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.main_pic];
    [self addSubview:self.addressImage];
    [self addSubview:self.addressLabel];
    [self addSubview:self.briefLabel];
    
    [self addSubview:self.shareButton];
    [self addSubview:self.commentsButton];
    [self addSubview:self.heartButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameNumberLabel.frame = CGRectMake(Left_Offset(10), Top_Offset(10), 30, 20);
    self.nameNumberLabel.font = [UIFont systemFontOfSize:16];
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.nameNumberLabel.frame), self.nameNumberLabel.frame.origin.y, Max_Width - 30, NameFontSize);
    [Tools setLabelOrigin:self.nameLabel originX:CGRectGetMaxX(self.nameNumberLabel.frame) originY:self.nameNumberLabel.frame.origin.y];
    
    self.main_pic.backgroundColor = TableView_Color;
    self.main_pic.frame = CGRectMake(self.nameNumberLabel.frame.origin.x, CGRectGetMaxY(self.nameNumberLabel.frame) + 10, Image_Width - 20, Image_Height);
    self.main_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    self.addressImage.frame = CGRectMake(self.nameNumberLabel.frame.origin.x, CGRectGetMaxY(self.main_pic.frame) + 10, self.nameNumberLabel.frame.size.height / 4 * 3, self.nameNumberLabel.frame.size.height);
    self.addressImage.image = [UIImage imageNamed:@"icon_address_sketch"];
    
    self.addressLabel.alpha = 0.5;
    self.addressLabel.frame = CGRectMake(CGRectGetMaxX(self.addressImage.frame) + 4, self.addressImage.frame.origin.y, self.main_pic.frame.size.width, self.addressImage.frame.size.height);
    self.addressLabel.font = [UIFont systemFontOfSize:16];
    
    self.briefLabel.frame = CGRectMake(self.nameNumberLabel.frame.origin.x, CGRectGetMaxY(self.addressImage.frame) + 10, Max_Width - 20, 16 * 4);
    self.briefLabel.font = [UIFont systemFontOfSize:BriefFontSize];
    self.briefLabel.numberOfLines = 0;
    if (self.briefLabel.text.length == 0) {
         self.briefLabel.frame = CGRectMake(self.nameNumberLabel.frame.origin.x, CGRectGetMaxY(self.addressImage.frame) + 10, Max_Width - 20, 0);
    }
    
    self.shareButton.frame = CGRectMake(self.main_pic.frame.origin.x + Left_Offset(10), CGRectGetMaxY(self.briefLabel.frame) + Top_Offset(10), 17 + 4 + 32, 17);
    [self.shareButton setImage:[UIImage imageNamed:@"icon_share_sketch"] forState:UIControlStateNormal];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.shareButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    self.shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 36);
    self.shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
    
    self.commentsButton.frame = CGRectMake(Max_Width / 2 - 17, self.shareButton.frame.origin.y, 17 + 4 + 32, 17);
    [self.commentsButton setImage:[UIImage imageNamed:@"item_action_comment_sketch"] forState:UIControlStateNormal];
//    [self.commentsButton setTitle:@"评论" forState:UIControlStateNormal];
    [self.commentsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.commentsButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    self.commentsButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 36);
    self.commentsButton.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
    
    self.heartButton.frame = CGRectMake(CGRectGetMaxX(self.main_pic.frame) - 32 - 17 - 4, self.shareButton.frame.origin.y, 17 + 4 + 32, 17);
    [self.heartButton setImage:[UIImage imageNamed:@"item_action_comment_sketch"] forState:UIControlStateNormal];
//    [self.heartButton setTitle:@"点赞" forState:UIControlStateNormal];
    [self.heartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.heartButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    self.heartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 36);
    self.heartButton.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
}

#pragma mark --- set方法
- (void)setRecommendModel:(RecommendModel *)recommendModel{
    if (!recommendModel) {
        NSLog(@"为空");
        return;
    }
    self.nameLabel.text = recommendModel.name;
    
    
    [self.main_pic sd_setImageWithURL:[NSURL URLWithString:recommendModel.main_pic]];
    
    self.addressLabel.text = recommendModel.address;
    [Tools setLabelOrigin:self.addressLabel originX:CGRectGetMaxX(self.addressImage.frame) + 4 originY:self.addressImage.frame.origin.y];
    
    self.briefLabel.text = recommendModel.brief;
    
    [self.commentsButton setTitle:recommendModel.comments forState:UIControlStateNormal];
    if ([recommendModel.comments isEqualToString:@"0"]) {
        [self.commentsButton setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    [self.heartButton setTitle:recommendModel.likes forState:UIControlStateNormal];
    if ([recommendModel.likes isEqualToString:@"0"]) {
        [self.heartButton setTitle:@"点赞" forState:UIControlStateNormal];
    }
    
    [self layoutIfNeeded];
}

#pragma mark ---- 懒加载
- (CGFloat)cellHeight{
    return _cellHeight = CGRectGetMaxY(self.shareButton.frame) + 10;
}

- (void)setIndex:(NSInteger)index{
    self.nameNumberLabel.text = [NSString stringWithFormat:@"%ld.",index + 1];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
