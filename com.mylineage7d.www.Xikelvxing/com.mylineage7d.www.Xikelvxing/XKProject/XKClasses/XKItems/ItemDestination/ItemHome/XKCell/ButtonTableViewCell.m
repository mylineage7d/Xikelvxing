//
//  ButtonTableViewCell.m
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ButtonTableViewCell.h"

@implementation ButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.cateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.cateButton];

    self.shoppingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.shoppingButton];
    
    self.scenicSpotsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.scenicSpotsButton];
    
    self.cateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_cateLabel];
    
    self.shoppingLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_shoppingLabel];
    
    self.scenicSpotsLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_scenicSpotsLabel];
    
    self.bigLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.bigLabel];
    
    self.smallLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.smallLabel];
    
    
    [self.cateButton setImage:[UIImage imageNamed:@"main_icon_food_sketch"] forState:UIControlStateNormal];
    self.cateButton.frame = CGRectMake(25,30,Button_Size,Button_Size);
    self.cateButton.layer.cornerRadius = Button_Size / 2;
    self.cateButton.tag = 201;
    
    [self.shoppingButton setImage:[UIImage imageNamed:@"main_icon_shoping_sketch"] forState:UIControlStateNormal];
    self.shoppingButton.frame = CGRectMake(Max_Width / 2 - Button_Size / 2, self.cateButton.frame.origin.y,Button_Size, Button_Size);
    self.shoppingButton.layer.cornerRadius = self.shoppingButton.frame.size.width / 2;
    self.shoppingButton.tag = 202;
    
    [self.scenicSpotsButton setImage:[UIImage imageNamed:@"main_icon_jingdian_sketch"] forState:UIControlStateNormal];
    self.scenicSpotsButton.frame = CGRectMake(Max_Width - Button_Size - 25, self.cateButton.frame.origin.y,Button_Size, Button_Size);
    self.scenicSpotsButton.layer.cornerRadius = self.scenicSpotsButton.frame.size.width / 2;
    self.scenicSpotsButton.tag = 203;
    
    self.cateLabel.frame = CGRectMake(_cateButton.frame.origin.x, CGRectGetMaxY(self.cateButton.frame), Button_Size, Lable_Size_Height);
    self.cateLabel.text = @"美食";
    self.cateLabel.font = [UIFont systemFontOfSize:14];
    self.cateLabel.textAlignment = NSTextAlignmentCenter;
    [self.cateLabel sizeToFit];
    [Tools setLabelCenter:self.cateLabel originX:self.cateButton.center.x originY:CGRectGetMaxY(self.cateButton.frame) + self.cateLabel.frame.size.height / 2];
    
    self.shoppingLabel.frame = CGRectMake(self.shoppingButton.frame.origin.x,self.cateLabel.frame.origin.y, Button_Size, Lable_Size_Height);
    self.shoppingLabel.text = @"购物";
    self.shoppingLabel.font = [UIFont systemFontOfSize:14];
    self.shoppingLabel.textAlignment = NSTextAlignmentCenter;
    [self.shoppingLabel sizeToFit];
    [Tools setLabelCenter:self.shoppingLabel originX:self.shoppingButton.center.x originY:CGRectGetMaxY(self.shoppingButton.frame) + self.shoppingLabel.frame.size.height / 2];
    
    self.scenicSpotsLabel.frame = CGRectMake(self.scenicSpotsButton.frame.origin.x, self.cateLabel.frame.origin.y, Button_Size, Lable_Size_Height);
    self.scenicSpotsLabel.text = @"景点";
    self.scenicSpotsLabel.font = [UIFont systemFontOfSize:14];
    self.scenicSpotsLabel.textAlignment = NSTextAlignmentCenter;
    [self.scenicSpotsLabel sizeToFit];
    [Tools setLabelCenter:self.scenicSpotsLabel originX:self.scenicSpotsButton.center.x originY:CGRectGetMaxY(self.scenicSpotsButton.frame) + self.scenicSpotsLabel.frame.size.height / 2];
    
    self.bigLabel.frame = CGRectMake(Max_Width / 2 - 150 / 2,CGRectGetMaxY(self.shoppingLabel.frame) + 15,150,Lable_Size_Height);
    self.bigLabel.text = @"推荐攻略";
    self.bigLabel.font = [UIFont systemFontOfSize:15];
    self.bigLabel.textAlignment = NSTextAlignmentCenter;
    [self.bigLabel sizeToFit];
    [Tools setLabelCenter:self.bigLabel originX:self.shoppingLabel.center.x originY:CGRectGetMaxY(self.shoppingLabel.frame) + self.bigLabel.frame.size.height / 2 + 20];
    
    self.smallLabel.frame = CGRectMake(Max_Width / 2 - 250 / 2,CGRectGetMaxY(self.bigLabel.frame),250,Lable_Size_Height);
    self.smallLabel.text = @"感受不一样的吃喝玩乐";
    self.smallLabel.font = [UIFont systemFontOfSize:13];
    self.smallLabel.textAlignment = NSTextAlignmentCenter;
    self.smallLabel.alpha = 0.5;
    [self.smallLabel sizeToFit];
    [Tools setLabelCenter:self.smallLabel originX:self.bigLabel.center.x originY:CGRectGetMaxY(self.bigLabel.frame) + self.smallLabel.frame.size.height / 2];
}

- (CGFloat)cellHeight{
    _cellHeight = 30 + self.cateButton.frame.size.height + self.cateLabel.frame.size.height + 15 + self.bigLabel.frame.size.height + self.smallLabel.frame.size.height + 30;
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
