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
//    self.main_pic = [[UIImageView alloc] init];
    self.content = [[UILabel alloc] init];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _webImageView = [YYAnimatedImageView new];
    
    [self.contentView addSubview:_webImageView];
    
    
    _progressLayer = [CAShapeLayer layer];
    
    [_webImageView.layer addSublayer:_progressLayer];

    //    self.num = [UILabel new];
    
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.dateLabel];
//    [self addSubview:self.main_pic];
    [self addSubview:self.content];

    
    [self addSubview:self.shareButton];
    [self addSubview:self.commentsButton];
    [self addSubview:self.heartButton];
    
    //    [self addSubview:self.num];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.headImage.frame = CGRectMake(Left_Offset(10), Top_Offset(10), Button_Size, Button_Size);
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width / 2;
    self.headImage.layer.masksToBounds = YES;
    //    self.headImage.image = [UIImage imageNamed:@"logo_512_sketch"];
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame), self.headImage.frame.origin.y, Max_Width - 30, NameFontSize);
    //    self.nameLabel.text = @"稀客旅行";
    [Tools setLabelOrigin:self.nameLabel text:self.nameLabel.text fontSize:NameFontSize originX:CGRectGetMaxX(self.headImage.frame) + 5 originY:(self.headImage.frame.size.height - self.nameLabel.frame.size.height) / 2 + 10];
    
    self.dateLabel.frame = CGRectMake(Max_Width - Right_Offset(10) - 37, self.nameLabel.frame.origin.y, 50, self.nameLabel.frame.size.height);
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel.alpha = 0.5;
    [self.dateLabel sizeToFit];
    
//    self.main_pic.frame = CGRectMake(0, CGRectGetMaxY(self.headImage.frame) + 10, Image_Width, Image_Height);
//    self.main_pic.backgroundColor = TableView_Color;
//    self.main_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    _webImageView.frame = CGRectMake(0, CGRectGetMaxY(self.headImage.frame) + 10, Image_Width, Image_Height);
    _webImageView.clipsToBounds = YES;
    _webImageView.contentMode = UIViewContentModeScaleAspectFill;
    _webImageView.backgroundColor = [UIColor whiteColor];
    
    _progressLayer.size = CGSizeMake(_webImageView.width, 4);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, _progressLayer.height / 2)];
    [path addLineToPoint:CGPointMake(_webImageView.width, _progressLayer.height / 2)];
    _progressLayer.lineWidth = 4;
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = CGPointMake(self.width / 2, self.height / 2);
    _indicator.hidden = YES;
    
    self.content.frame = CGRectMake(self.headImage.frame.origin.x, CGRectGetMaxY(self.webImageView.frame) + 10, Max_Width - 20, 16);
    self.content.font = [UIFont systemFontOfSize:BriefFontSize];
    self.content.textAlignment = NSTextAlignmentCenter;
    [Tools setLabelCenter:self.content text:self.content.text fontSize:BriefFontSize originX:self.webImageView.center.x originY:CGRectGetMaxY(self.webImageView.frame)];
    
    self.shareButton.frame = CGRectMake(self.webImageView.frame.origin.x + Left_Offset(20), CGRectGetMaxY(self.content.frame) + Top_Offset(10), 17 + 4 + 32, 17);
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
    
    self.heartButton.frame = CGRectMake(CGRectGetMaxX(self.webImageView.frame) - 32 - 17 - 4 - 10, self.shareButton.frame.origin.y, 17 + 4 + 32, 17);
    [self.heartButton setImage:[UIImage imageNamed:@"item_action_like_sketch"] forState:UIControlStateNormal];
//    [self.heartButton setTitle:@"点赞" forState:UIControlStateNormal];
    [self.heartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.heartButton.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    self.heartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 36);
    self.heartButton.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
    self.heartButton.adjustsImageWhenHighlighted = NO;
    
    //    self.num.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, self.nameLabel.frame.origin.y, 100, 50);
}

- (void)setDisModel:(DiscoverModel *)disModel{
    if (!disModel) {
        NSLog(@"disModel为空");
        return;
    }
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:disModel.avatarUrl]];
    
    self.nameLabel.text = disModel.username;
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
    NSTimeInterval interval = [nowDate timeIntervalSinceDate:disModel.createdAt];
    self.dateLabel.text = [NSString stringWithFormat:@"%.f周前",interval / 3600 / 24 / 7 - 1];
    
    _indicator.hidden = NO;
    [_indicator startAnimating];
    __weak typeof(self) _self = self;
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [_webImageView setImageWithURL:[NSURL URLWithString:disModel.imageUrls[0]]
                       placeholder:nil
                           options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressive
                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                              if (expectedSize > 0 && receivedSize > 0) {
                                  CGFloat progress = (CGFloat)receivedSize / expectedSize;
                                  progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
                                  if (_self.progressLayer.hidden) _self.progressLayer.hidden = NO;
                                  _self.progressLayer.strokeEnd = progress;
                              }
                          } transform:nil
                        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                            if (stage == YYWebImageStageFinished) {
                                _self.progressLayer.hidden = YES;
                                [_self.indicator stopAnimating];
                                _self.indicator.hidden = YES;
//                                if (!image) _self.label.hidden = NO;
                            }
                        }];
    
    self.content.text = disModel.content;
    
    [self.commentsButton setTitle:disModel.comments forState:UIControlStateNormal];
    if ([disModel.comments isEqualToString:@"0"]) {
        [self.commentsButton setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    [self.heartButton setTitle:disModel.likes forState:UIControlStateNormal];
    if ([disModel.likes isEqualToString:@"0"]) {
        [self.heartButton setTitle:@"点赞" forState:UIControlStateNormal];
    }
    
    AVUser *user = [AVUser currentUser];
    
    if (user != nil) {
        AVQuery *query = [AVQuery queryWithClassName:@"MomentLike"];
        [query whereKey:@"momentId" equalTo:disModel.objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
//                NSLog(@"id:%@",disModel.objectId);
                
                for (AVObject *ob in objects) {

                    if ([[ob objectForKey:@"userId"] isEqualToString:user.objectId]) {
                        self.heartButton.selected = YES;
                        [self.heartButton setImage:[UIImage imageNamed:@"item_action_like_fill_sketch"] forState:UIControlStateNormal];
                    }
                }
            } else {
                // 输出错误信息
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
    [self layoutIfNeeded];
}

- (void)setIndex:(NSInteger)index{
    //    self.num.text = [NSString stringWithFormat:@"%ld.",index + 1];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
