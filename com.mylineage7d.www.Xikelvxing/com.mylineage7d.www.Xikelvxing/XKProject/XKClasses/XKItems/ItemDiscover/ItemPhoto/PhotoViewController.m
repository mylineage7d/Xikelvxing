//
//  PhotoViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()<UIScrollViewDelegate>
@property (nonatomic,assign)BOOL tapState;
@end

@implementation PhotoViewController

- (void)loadView {
    self.photoV = [[PhotoView alloc] initWithFrame:Main_Screen];
    self.view = self.photoV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置scroll
    [self setScrollView];
}

#pragma mark ---- 设置scroll
- (void)setScrollView {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.tapState = YES;
    [self.photoV.scrollV addGestureRecognizer:tap];
    
    self.photoV.scrollV.contentSize = CGSizeMake(Max_Width * self.imageArray.count, Max_Height);
    
    for (int i = 0; i < self.imageArray.count; i++) {
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(Max_Width * i, 0, Max_Width, Max_Height - 64)];

        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, Max_Width, Max_Height - 64)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.imageArray[i]]];
        
        [scroll addSubview:imageV];
        [self.photoV.scrollV addSubview:scroll];
    }
    self.photoV.pageLabel.text = [NSString stringWithFormat:@"1/%ld",self.imageArray.count];
}

#pragma mark ---- UIScrollViewDelegate 方法
// 滚动停止事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.photoV.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)(scrollView.contentOffset.x / Max_Width) + 1,self.imageArray.count];
    
    // 把左边的或者右边的都变为正常大小
    
    int n = self.photoV.scrollV.contentOffset.x/Max_Width;
    
    if (n > 0 && n < self.imageArray.count - 1) {
        UIScrollView *scroll1 = self.photoV.scrollV.subviews[n-1];
        UIScrollView *scroll2 = self.photoV.scrollV.subviews[n+1];
        
        scroll1.zoomScale = 1;
        scroll2.zoomScale = 1;
    }
}

// 缩小时 图片放中间
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{

    CGSize imageViewSize = scrollView.subviews[0].frame.size;
    CGSize scrollViewSize = scrollView.bounds.size;
    CGFloat verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0;
    CGFloat horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0;
    scrollView.contentInset = UIEdgeInsetsMake(verticalPadding, horizontalPadding, verticalPadding, horizontalPadding);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews[0];
}

// Tap手势方法
- (void)tapAction {
    if (self.tapState == YES) {
        self.navigationController.navigationBar.hidden = YES;
        self.photoV.scrollV.backgroundColor = [UIColor blackColor];
        [self.photoV.pageLabel setTextColor:[UIColor whiteColor]];
        self.tapState = NO;
    } else {
        self.navigationController.navigationBar.hidden = NO;
        self.photoV.scrollV.backgroundColor = [UIColor whiteColor];
        [self.photoV.pageLabel setTextColor:[UIColor blackColor]];
        self.tapState = YES;
    }
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
//    self.tabBarController.tabBar.hidden = YES;
    
    for (int i = 0; i < self.imageArray.count; i++) {
        UIScrollView *scroll = [self.photoV.scrollV subviews][i];
        scroll.delegate = self;
        scroll.maximumZoomScale = 2.0;
//        scroll.minimumZoomScale = 0.5;
    }
    self.photoV.scrollV.delegate = self;

}

#pragma mark --- 懒加载
- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSArray alloc] init];
    }
    return _imageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
