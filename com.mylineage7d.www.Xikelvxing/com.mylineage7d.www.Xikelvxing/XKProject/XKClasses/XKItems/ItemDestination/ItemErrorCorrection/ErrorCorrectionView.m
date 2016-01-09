//
//  ErrorCorrectionView.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/26.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "ErrorCorrectionView.h"

@implementation ErrorCorrectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews {
    self.backgroundColor = TableView_Color;
    
    self.label = [UILabel new];
    self.textView = [UITextView new];
    
    self.label.frame = CGRectMake(Left_Offset(7), Top_Offset(64 + 17), Max_Width - 14, 17);
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.alpha = 0.3;
    self.label.backgroundColor = TableView_Color;
    self.label.text = @"务必留下联系方式,以便和您进一步沟通";
    self.label.enabled = NO;
    [self.label sizeToFit];
    
    self.textView.frame = CGRectMake(Left_Offset(3), Top_Offset(64 + 10), Max_Width - 6, Max_Height / 2 - 100 - 64);
    self.textView.backgroundColor = TableView_Color;
    self.textView.font = [UIFont systemFontOfSize:17];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 30;
    self.flowLayout.minimumInteritemSpacing = 20;
    self.flowLayout.itemSize = CGSizeMake(50, 50);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textView.frame),  Max_Width, Max_Height / 2) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = TableView_Color;
    
    [self addSubview:self.textView];
    [self addSubview:self.label];
    [self addSubview:self.collectionView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
