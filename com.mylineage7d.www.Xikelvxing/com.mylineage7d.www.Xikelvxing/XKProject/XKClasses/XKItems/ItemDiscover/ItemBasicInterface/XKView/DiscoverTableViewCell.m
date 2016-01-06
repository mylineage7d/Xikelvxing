//
//  DiscoverTableViewCell.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/23.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#define NameFontSize 17
#define BriefFontSize 16
#define SmallFontSize 14

#import "DiscoverTableViewCell.h"

@implementation DiscoverTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor whiteColor];
    
    self.headImage = [[UIImageView alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.dateLabel = [UILabel new];
    self.main_pic = [[UIImageView alloc] init];
    self.content = [[UILabel alloc] init];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //    self.num = [UILabel new];
    
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.main_pic];
    [self addSubview:self.content];
    
    [self addSubview:self.shareButton];
    [self addSubview:self.commentsButton];
    [self addSubview:self.heartButton];
    
    //    [self addSubview:self.num];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.headImage.frame = CGRectMake(Left_Offset(0), Top_Offset(0), Button_Size, Button_Size);
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width / 2;
    self.headImage.layer.masksToBounds = YES;
    //    self.headImage.image = [UIImage imageNamed:@"logo_512_sketch"];
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame), self.headImage.frame.origin.y, Max_Width - 30, NameFontSize);
    //    self.nameLabel.text = @"稀客旅行";
    [Tools setLabelOrigin:self.nameLabel text:self.nameLabel.text fontSize:NameFontSize originX:CGRectGetMaxX(self.headImage.frame) + 5 originY:(self.headImage.frame.size.height - self.nameLabel.frame.size.height) / 2 + 10];
    
    self.dateLabel.frame = CGRectMake(Max_Width - Right_Offset(0) - 37, self.nameLabel.frame.origin.y, 50, self.nameLabel.frame.size.height);
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel.alpha = 0.5;
    [self.dateLabel sizeToFit];
    
    self.main_pic.frame = CGRectMake(0, CGRectGetMaxY(self.headImage.frame) + 10, Image_Width, Image_Height);
    self.main_pic.backgroundColor = TableView_Color;
    self.main_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    self.content.frame = CGRectMake(self.headImage.frame.origin.x, CGRectGetMaxY(self.main_pic.frame) + 10, Max_Width - 20, 16);
    self.content.font = [UIFont systemFontOfSize:BriefFontSize];
    self.content.textAlignment = NSTextAlignmentCenter;
    [Tools setLabelCenter:self.content text:self.content.text fontSize:BriefFontSize originX:self.main_pic.center.x originY:CGRectGetMaxY(self.main_pic.frame)];
    
    self.shareButton.frame = CGRectMake(self.main_pic.frame.origin.x + Left_Offset(0), CGRectGetMaxY(self.content.frame) + Top_Offset(0), 17 + 4 + 32, 17);
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
    [self.heartButton setImage:[UIImage imageNamed:@"item_action_like_sketch"] forState:UIControlStateNormal];
//    [self.heartButton setTitle:@"点赞" forState:UIControlStateNormal];
    [self.heartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.heartButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    self.heartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 36);
    self.heartButton.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
    
    //    self.num.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, self.nameLabel.frame.origin.y, 100, 50);
}

- (void)setDisModel:(DiscoverModel *)disModel{
    if (!disModel) {
        NSLog(@"disModel为空");
        return;
    }
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:disModel.avatarUrl]];
    
    self.nameLabel.text = disModel.username;
    
    //    NSDateFormatter *myFormatter = [[NSDateFormatter alloc]init];
    //    myFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    NSString *strDate = [myFormatter stringForObjectValue:disModel.updatedAt];
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
    NSTimeInterval interval = [nowDate timeIntervalSinceDate:disModel.createdAt];
    self.dateLabel.text = [NSString stringWithFormat:@"%.f周前",interval / 3600 / 24 / 7 - 1];
    
    [self.main_pic sd_setImageWithURL:[NSURL URLWithString:disModel.imageUrls[0]]];
    
    self.content.text = disModel.content;
    
    [self.commentsButton setTitle:disModel.comments forState:UIControlStateNormal];
    if ([disModel.comments isEqualToString:@"0"]) {
        [self.commentsButton setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    [self.heartButton setTitle:disModel.likes forState:UIControlStateNormal];
    if ([disModel.likes isEqualToString:@"0"]) {
        [self.heartButton setTitle:@"点赞" forState:UIControlStateNormal];
    }

    [self layoutIfNeeded];
}

- (void)setIndex:(NSInteger)index{
    //    self.num.text = [NSString stringWithFormat:@"%ld.",index + 1];
}

// 设置cell高度
+(CGFloat)cellHeight:(DiscoverModel *)model {
    
    UILabel *content = [[UILabel alloc] init];
    content.frame = CGRectMake(0,0, Max_Width - 20, 16);
    content.font = [UIFont systemFontOfSize:BriefFontSize];
    content.textAlignment = NSTextAlignmentCenter;
    content.text = model.content;
    [Tools setLabelHeight:content text:content.text fontSize:BriefFontSize];
    
    return Top_Offset(0) + Button_Size + 10 + Image_Height + 10 + content.frame.size.height + 10 + 17 + 10;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
