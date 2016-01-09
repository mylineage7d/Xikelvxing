//
//  RecAddressAndPathCell.m
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecAddressAndPathCell.h"

@implementation RecAddressAndPathCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.addressTitle = [UILabel labelWithFrame:CGRectMake(Left_Offset(10), Top_Offset(10), Max_Width - 20, 17) text:@"地址"];
    self.addressTitle.font = [UIFont systemFontOfSize:16];
    self.addressTitle.alpha = 0.5;
    
    self.address = [UILabel labelWithFrame:CGRectMake(self.addressTitle.frame.origin.x, CGRectGetMaxY(self.addressTitle.frame) + Left_Offset(10) , Max_Width - 20, 17) fontSize:16 lineBreak:YES];
    
    self.travelTitle = [UILabel labelWithFrame:CGRectMake(Left_Offset(10), CGRectGetMaxY(self.address.frame) + Top_Offset(10), Max_Width - 20, 17) text:@"路线"];
    self.travelTitle.font = [UIFont systemFontOfSize:16];
    self.travelTitle.alpha = 0.5;
    
    self.travel = [UILabel labelWithFrame:CGRectMake(self.addressTitle.frame.origin.x, CGRectGetMaxY(self.travelTitle.frame) + Left_Offset(10), self.address.frame.size.width, 16) fontSize:16 lineBreak:YES];
    self.travel.backgroundColor = [UIColor colorWithRed:0.640 green:1.000 blue:0.531 alpha:1.000];
    
    self.map = [UIImageView imageViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.travel.frame) + Top_Offset(10), Max_Width, Left_Offset(10)) imageName:@"avatar_background_sketch"];
    
    self.phoneTitle = [UILabel labelWithFrame:CGRectMake(Left_Offset(10), CGRectGetMaxY(self.map.frame) + Top_Offset(10), Max_Width - 20, 17) text:@"电话"];
    self.phoneTitle.font = [UIFont systemFontOfSize:16];
    self.phoneTitle.alpha = 0.5;
    
    self.phone = [UILabel labelWithFrame:CGRectMake(self.addressTitle.frame.origin.x, CGRectGetMaxY(self.phoneTitle.frame) + Left_Offset(10), self.travelTitle.frame.size.width, 40) fontSize:16 lineBreak:YES];
    
    self.openinghoursTitle = [UILabel labelWithFrame:CGRectMake(Left_Offset(10), CGRectGetMaxY(self.phone.frame) + Top_Offset(10), Max_Width - 20, 17) text:@"营业时间"];
    self.openinghoursTitle.font = [UIFont systemFontOfSize:16];
    self.openinghoursTitle.alpha = 0.5;

    self.openinghours = [UILabel labelWithFrame:CGRectMake(self.addressTitle.frame.origin.x, CGRectGetMaxY(self.openinghoursTitle.frame) + Left_Offset(10), self.address.frame.size.width, 16) fontSize:16 lineBreak:YES];
    
    
    [self addSubview:self.addressTitle];
    [self addSubview:self.address];
    [self addSubview:self.travelTitle];
    [self addSubview:self.travel];
    [self addSubview:self.map];
    [self addSubview:self.phoneTitle];
    [self addSubview:self.phone];
    [self addSubview:self.openinghoursTitle];
    [self addSubview:self.openinghours];
}

#pragma mark ---- set方法
- (void)setModel:(RecommendModel *)model{
    self.address.text = model.address;
    self.travel.text = model.travel;
    self.phone.text = model.phone;
    self.openinghours.text = model.openinghours;
    
    [self setViewAdaptive];
    
    if ([model.phone isEqualToString:@""]) {
        self.phoneTitle.frame = CGRectMake(0, CGRectGetMaxY(self.map.frame), 0, 0);
        self.phone.frame = CGRectMake(0, CGRectGetMaxY(self.phoneTitle.frame) + Left_Offset(10), 0, 0);
    }
    if ([model.openinghours isEqualToString:@""]) {
        self.openinghoursTitle.frame = CGRectMake(0, CGRectGetMaxY(self.phone.frame), 0, 0);
        self.openinghours.frame = CGRectMake(0, CGRectGetMaxY(self.openinghoursTitle.frame), 0, 0);
    }
    [self layoutIfNeeded];
}

#pragma mark ---- Cell高度
- (CGFloat)cellHeight{
    if ([self.openinghours.text isEqualToString:@""]) {
        return _cellHeight = CGRectGetMaxY(self.phone.frame) + Left_Offset(10);
    } else if ([self.phone.text isEqualToString:@""]) {
        return _cellHeight = CGRectGetMaxY(self.map.frame) + Left_Offset(10);
    }
    return _cellHeight = CGRectGetMaxY(self.openinghours.frame) + Left_Offset(10);
}

#pragma mark ---- 自适应
- (void)setViewAdaptive{
    [Tools setLabelOrigin:self.addressTitle originX:Left_Offset(10) originY:Top_Offset(10)];
    
    [Tools setLabelOrigin:self.address text:self.address.text fontSize:16 originX:Left_Offset(10) originY:CGRectGetMaxY(self.addressTitle.frame) + Left_Offset(10)];

    [Tools setLabelOrigin:self.travelTitle originX:Left_Offset(10) originY:CGRectGetMaxY(self.address.frame) + Top_Offset(10)];
    
    [Tools setLabelOrigin:self.travel text:self.travel.text fontSize:16 originX:Left_Offset(10) originY:CGRectGetMaxY(self.travelTitle.frame) + Left_Offset(10)];
    
    self.map.frame = CGRectMake(0, CGRectGetMaxY(self.travel.frame) + Top_Offset(10), Image_Width,50);
    
    [Tools setLabelOrigin:self.phoneTitle originX:Left_Offset(10) originY:CGRectGetMaxY(self.map.frame) + Top_Offset(10)];
    
    [Tools setLabelOrigin:self.phone originX:Left_Offset(10) originY:CGRectGetMaxY(self.phoneTitle.frame) + Left_Offset(10)];
    
    [Tools setLabelOrigin:self.openinghoursTitle originX:Left_Offset(10) originY:CGRectGetMaxY(self.phone.frame) + Top_Offset(10)];
    
    [Tools setLabelOrigin:self.openinghours text:self.openinghours.text fontSize:16 originX:Left_Offset(10) originY:CGRectGetMaxY(self.openinghoursTitle.frame) + Left_Offset(10)];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
