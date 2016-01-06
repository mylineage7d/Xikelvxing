//
//  RecCommentCell.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/26.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#define NameFontSize 17
#define BriefFontSize 16
#define SmallFontSize 14

#import "RecCommentCell.h"

@implementation RecCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    self.headImage = [[UIImageView alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.dateLabel = [UILabel new];
    self.commentLabel = [UILabel new];
    
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.commentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.headImage.frame = CGRectMake(Left_Offset(0), Top_Offset(0), [UIScreen mainScreen].bounds.size.width / 9, [UIScreen mainScreen].bounds.size.width / 9);
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
    
    self.commentLabel.frame = CGRectMake(self.headImage.frame.origin.x, CGRectGetMaxY(self.headImage.frame) + Top_Offset(0), Max_Width - 20, 17);
    [Tools setLabelOrigin:self.commentLabel fontSize:NameFontSize];
}

- (void)setPost:(AVObject *)post {
    
    NSString *objectID = [post objectForKey:@"userId"];
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    AVObject *object = [query getObjectWithId:objectID];
  
    NSString *imageUrl = [object objectForKey:@"avatarUrl"];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.nameLabel.text = [object objectForKey:@"username"];
    self.commentLabel.text = [post objectForKey:@"content"];
    
    [self layoutIfNeeded];
}

#pragma mark ---- Cell高度
- (CGFloat)cellHeight{
    return CGRectGetMaxY(self.commentLabel.frame) + 10;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
