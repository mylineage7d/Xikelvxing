//
//  RecommendTableViewCell.m
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendTableViewCell.h"


#define TitleSize 15
#define PlaceNumSize 14

@implementation RecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imageUrl = [[UIImageView alloc] initWithFrame:CGRectMake(Left_Offset(10), Top_Offset(10),Max_Width / 3 ,Max_Width / 3 / 4 * 3)];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageUrl.frame) + Left_Offset(8), self.imageUrl.frame.origin.y, Max_Width - self.imageUrl.frame.size.width - 20 - 8,self.imageUrl.frame.size.height / 2)];
    self.title.font = [UIFont systemFontOfSize:TitleSize];
    
    self.placeNum = [[UILabel alloc] initWithFrame:CGRectMake(self.title.frame.origin.x, CGRectGetMaxY(self.imageUrl.frame) - PlaceNumSize, self.title.frame.size.width / 3 * 2,PlaceNumSize)];
    self.placeNum.font = [UIFont systemFontOfSize:PlaceNumSize];
    self.placeNum.alpha = 0.5;
    
    self.marks = [[UILabel alloc] initWithFrame:CGRectMake(Max_Width - PlaceNumSize - 15, self.placeNum.frame.origin.y, PlaceNumSize + 20, PlaceNumSize)];
    self.marks.font = [UIFont systemFontOfSize:PlaceNumSize];
   
    self.heartImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.marks.frame.origin.x - PlaceNumSize - 5, self.placeNum.frame.origin.y, PlaceNumSize, PlaceNumSize)];
    self.heartImage.image = [UIImage imageNamed:@"icon_love_sketch"];
    
    [self addSubview:self.imageUrl];
    [self addSubview:self.title];
    [self addSubview:self.placeNum];
    [self addSubview:self.marks];
    [self addSubview:self.heartImage];
    
}

// set方法
- (void)setDestinationModel:(DestinationModel *)destinationModel{
    if (!destinationModel) {
        NSLog(@"为空");
        return;
    }
    [self.imageUrl sd_setImageWithURL:[NSURL URLWithString:destinationModel.imageUrl]];
    [self.imageUrl layoutIfNeeded];
    
    self.title.text = destinationModel.title;
    [Tools setLabelHeight:self.title text:destinationModel.title fontSize:TitleSize];
    
    NSString *str = [NSString stringWithFormat:@"%ld个旅行地推荐",destinationModel.placeIdsArray.count];
    self.placeNum.text = str;
    [Tools setLabelOrigin:self.placeNum originX:self.title.frame.origin.x originY:CGRectGetMaxY(self.imageUrl.frame) - PlaceNumSize];

    self.marks.text = destinationModel.marks;
    [Tools setLabelOrigin:self.marks originX:Max_Width - PlaceNumSize - 15 originY:self.placeNum.frame.origin.y];

}

- (CGFloat)cellHeight{
    _cellHeight = self.imageUrl.frame.size.height + 20;
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
