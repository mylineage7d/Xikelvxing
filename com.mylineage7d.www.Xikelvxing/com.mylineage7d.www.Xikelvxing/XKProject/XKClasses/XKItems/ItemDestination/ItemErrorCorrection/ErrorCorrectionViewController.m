//
//  ErrorCorrectionViewController.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/26.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "ErrorCorrectionViewController.h"
#import "ErrorCorrectionCell.h"
#import "AddCollectionViewCell.h"
@interface ErrorCorrectionViewController ()<UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *imageArray;
@end

@implementation ErrorCorrectionViewController

- (void)loadView {
    self.errorV = [[ErrorCorrectionView alloc] init];
    self.view = self.errorV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置NavBar
    [self setNavBar];
    
    // 设置CollectionView
    [self setCollectionView];
}

#pragma mark ---- 设置CollectionView
- (void)setCollectionView {
    self.errorV.collectionView.dataSource = self;
    [self.errorV.collectionView registerClass:[ErrorCorrectionCell class] forCellWithReuseIdentifier:cErrorCorrection_Cell];
    [self.errorV.collectionView registerClass:[AddCollectionViewCell class] forCellWithReuseIdentifier:cAddCollectionView_Cell];
}

#pragma mark ---- UICollectionView 代理方法

// 返回每个分组有多少个单元
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count + 1;
}

// 返回每个单元
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ErrorCorrectionCell *errorCorrectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cErrorCorrection_Cell forIndexPath:indexPath];
    
    AddCollectionViewCell *addCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cAddCollectionView_Cell forIndexPath:indexPath];
    
    if (self.imageArray.count == 0) {
        return addCollectionCell;
    } else if (indexPath.row < self.imageArray.count) {
        return errorCorrectionCell;
    } else {
        return addCollectionCell;
    }
}

// 点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark ---- UITextView代理方法
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.errorV.label.text = @"务必留下联系方式,以便和您进一步沟通";
    } else {
        self.errorV.label.text = @"";
    }
}

#pragma mark ---- 设置NavBar
- (void)setNavBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_send_light_sketch"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

// 评论发送
- (void)rightBarButtonAction {
    NSLog(@"%@",self.esPlaceId);
    
    AVUser *currentUser = [AVUser currentUser];
    AVObject *post = [AVObject objectWithClassName:@"PlaceComment"];
    
    [post setObject:self.errorV.textView.text forKey:@"content"];
    [post setObject:self.esPlaceId forKey:@"esPlaceId"];
    [post setObject:currentUser.objectId forKey:@"userId"];
    
    [post save];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"评论成功"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.errorV.textView.delegate = self;
    self.errorV.collectionView.delegate = self;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.errorV.textView.delegate = nil;
    self.errorV.collectionView.delegate = nil;
}

#pragma mark ---- 懒加载
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
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
