//
//  RecButtonVIewCell.m
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecButtonVIewCell.h"

@implementation RecButtonVIewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat interval = (Max_Width - 20 * 2 - Button_Size * 4) / 3;
    
    self.uploadPicturesButton = [UIButton buttonWithFrame:CGRectMake(20, 20, Button_Size, Button_Size) normalImageName:@"place_action_camera_sketch"];
    
    self.uploadPicturesLabel = [UILabel labelWithFrame:CGRectMake(self.uploadPicturesButton.frame.origin.x, CGRectGetMaxY(self.uploadPicturesButton.frame), Button_Size, Lable_Size_Height) text:@"传照片"];
    self.uploadPicturesLabel.textAlignment = NSTextAlignmentCenter;
    self.uploadPicturesLabel.font = [UIFont systemFontOfSize:13];
    [Tools setLabelCenter:self.uploadPicturesLabel originX:self.uploadPicturesButton.center.x originY:(CGRectGetMaxY(self.uploadPicturesButton.frame) + self.uploadPicturesLabel.frame.size.height / 2)];
    
    self.writeCommentButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.uploadPicturesButton.frame) + interval, self.uploadPicturesButton.frame.origin.y, Button_Size, Button_Size) normalImageName:@"place_action_comment_sketch"];
    
    self.writeCommentLabel = [UILabel labelWithFrame:CGRectMake(self.writeCommentButton.frame.origin.x, CGRectGetMaxY(self.writeCommentButton.frame), Button_Size, Lable_Size_Height) text:@"写评论"];
    self.writeCommentLabel.textAlignment = NSTextAlignmentCenter;
    self.writeCommentLabel.font = [UIFont systemFontOfSize:13];
    [Tools setLabelCenter:self.writeCommentLabel originX:self.writeCommentButton.center.x originY:(CGRectGetMaxY(self.writeCommentButton.frame) + self.writeCommentLabel.frame.size.height / 2)];
    
    self.errorCorrectionButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.writeCommentButton.frame) + interval, self.uploadPicturesButton.frame.origin.y, Button_Size, Button_Size) normalImageName:@"place_action_bug_sketch"];
    
    self.errorCorrectionLabel = [UILabel labelWithFrame:CGRectMake(self.errorCorrectionButton.frame.origin.x, CGRectGetMaxY(self.errorCorrectionButton.frame), Button_Size, Lable_Size_Height) text:@"纠错"];
    self.errorCorrectionLabel.textAlignment = NSTextAlignmentCenter;
    self.errorCorrectionLabel.font = [UIFont systemFontOfSize:13];
    [Tools setLabelCenter:self.errorCorrectionLabel originX:self.errorCorrectionButton.center.x originY:(CGRectGetMaxY(self.writeCommentButton.frame) + self.errorCorrectionLabel.frame.size.height / 2)];
    
    self.shareButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.errorCorrectionButton.frame) + interval, self.uploadPicturesButton.frame.origin.y, Button_Size, Button_Size) normalImageName:@"place_action_share_sketch"];
    
    self.shareLabel = [UILabel labelWithFrame:CGRectMake(self.shareButton.frame.origin.x, CGRectGetMaxY(self.shareButton.frame), Button_Size, Lable_Size_Height) text:@"分享"];
    self.shareLabel.textAlignment = NSTextAlignmentCenter;
    self.shareLabel.font = [UIFont systemFontOfSize:13];
    [Tools setLabelCenter:self.shareLabel originX:self.shareButton.center.x originY:(CGRectGetMaxY(self.writeCommentButton.frame) + self.shareLabel.frame.size.height / 2)];
    
    [self addSubview:self.uploadPicturesButton];
    [self addSubview:self.uploadPicturesLabel];
    [self addSubview:self.writeCommentButton];
    [self addSubview:self.writeCommentLabel];
    [self addSubview:self.errorCorrectionButton];
    [self addSubview:self.errorCorrectionLabel];
    [self addSubview:self.shareButton];
    [self addSubview:self.shareLabel];
}

- (CGFloat)cellHeight{
    return _cellHeight = CGRectGetMaxY(self.uploadPicturesLabel.frame) + 20;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
