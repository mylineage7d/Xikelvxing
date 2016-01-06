//
//  DetailButtonViewCell.m
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//
#define TitleSize 15
#define PlaceNumSize 14

#import "DetailButtonViewCell.h"

@implementation DetailButtonViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor whiteColor];
    
    self.main_pic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,Max_Width / 3 ,Max_Width / 3 / 4 * 3)];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.main_pic.frame) + 8, self.main_pic.frame.origin.y,Max_Width - self.main_pic.frame.size.width - 24,TitleSize)];
    self.name.font = [UIFont systemFontOfSize:TitleSize];
    self.name.numberOfLines = 0;
    self.localname = [UILabel labelWithFrame:CGRectMake(self.name.frame.origin.x, CGRectGetMaxY(self.name.frame), 10, 10) fontSize:PlaceNumSize lineBreak:NO];
    self.localname.alpha = 0.8;
    
    self.type = [[UILabel alloc] initWithFrame:CGRectMake(self.name.frame.origin.x, CGRectGetMaxY(self.main_pic.frame) - PlaceNumSize, self.name.frame.size.width - Right_Offset(0),PlaceNumSize)];
    self.type.font = [UIFont systemFontOfSize:PlaceNumSize];
    self.type.alpha = 0.5;
    
    [self addSubview:self.main_pic];
    [self addSubview:self.name];
    [self addSubview:self.localname];
    [self addSubview:self.type];
}

#pragma mark ---- 懒加载
- (void)setModel:(RecommendModel *)model{
    if (!model) {
        NSLog(@"为空");
        return;
    }
    [self.main_pic sd_setImageWithURL:[NSURL URLWithString:model.main_pic]];
    [self.main_pic layoutIfNeeded];
    
    self.name.text = model.name;
    [Tools setLabelHeight:self.name text:model.name fontSize:TitleSize];
    
    self.localname.text = model.localname;
    [Tools setLabelOrigin:self.localname originX:self.name.frame.origin.x originY:CGRectGetMaxY(self.name.frame)];
    
//    NSLog(@"1,%@",model.score);
//    NSLog(@"2,%@",model.location);
}

#pragma mark ---- Cell高度
- (CGFloat)cellHeight{
    _cellHeight = self.main_pic.frame.size.height + 20;
    return _cellHeight;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
