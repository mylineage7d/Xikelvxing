//
//  RecommendViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendDetailCell.h"
#import "RecCellDetailViewController.h"
#import "WriteCommentViewController.h"
#import "LoginViewController.h"
@interface RecommendViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation RecommendViewController

- (void)loadView{
    self.recommendV = [[RecommendView alloc] initWithFrame:Main_Screen];
    self.view = self.recommendV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 赋值
    [self setData];
    
    // cell数据
    [self setCellData];
    
    // 设置tableView
    [self setTableView];
    
    // 设置NavigationBar
    [self setNavBar];
}

#pragma mark --- 解析数据
- (void)setCellData{
    [JXDataMethod requestPlaceIdsArray:self.desModel.placeIdsArray block:^(NSArray *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataArray = (NSMutableArray *)array;
            [self.recommendV.tableView reloadData];
        });
    }];
}

#pragma mark --- 头视图数据
- (void)setData{
    if (!self.desModel) {
        NSLog(@"为空啊");
        return;
    }

    [self.recommendV.imageUrl sd_setImageWithURL:[NSURL URLWithString:self.desModel.imageUrl]];

    self.recommendV.title.text = self.desModel.title;
    [Tools setLabelHeight:self.recommendV.title text:self.desModel.title fontSize:17];
    
    NSString *str = self.desModel.content;
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    
    self.recommendV.content.text = str4;
    [Tools setLabelHeight:self.recommendV.content text:str4 fontSize:16];
    [Tools setLabelOrigin:self.recommendV.content text:str4 fontSize:16 originX:self.recommendV.title.frame.origin.x originY:CGRectGetMaxY(self.recommendV.title.frame)];
    
    CGRect rect3 = self.recommendV.headV.frame;
    rect3.size.height = self.recommendV.imageUrl.frame.size.height + self.recommendV.title.frame.size.height + self.recommendV.content.frame.size.height + self.recommendV.headButton.frame.size.height / 2;
    self.recommendV.headV.frame = rect3;
    
    [self.recommendV layoutIfNeeded];
}

#pragma mark --- 设置tableView
- (void)setTableView{
    self.recommendV.tableView.tableHeaderView = self.recommendV.headV;
    self.recommendV.tableView.dataSource = self;
    
    // Cell注册
    [self.recommendV.tableView registerClass:[RecommendDetailCell class] forCellReuseIdentifier:cRecommendDetail_Cell];
}

#pragma mark ---- 设置NavigationBar
- (void)setNavBar{

    UIBarButtonItem *destinationButton = [[UIBarButtonItem alloc] initWithCustomView:self.recommendV.leftNavBarView];
    self.navigationItem.leftBarButtonItem = destinationButton;
    [self.recommendV.leftNavBarView.tapNavBar addTarget:self action:@selector(tapLeftNavBarAction)];
    
#warning ---- 右NavBar少 地图&分享 功能
//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:self.destinationV.searchButton];
//    self.navigationItem.rightBarButtonItem = searchButton;
}

// 返回
- (void)tapLeftNavBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- UITableView代理方法
// cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendDetailCell *recommendDetailCell = [tableView dequeueReusableCellWithIdentifier:cRecommendDetail_Cell forIndexPath:indexPath];
    recommendDetailCell.selectedBackgroundView = [[UIView alloc] initWithFrame:recommendDetailCell.frame];
    recommendDetailCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    RecommendModel *model = self.dataArray[indexPath.row];
    recommendDetailCell.index = indexPath.row;
    recommendDetailCell.recommendModel = model;
    self.cellHeight = recommendDetailCell.cellHeight;
    
    [recommendDetailCell.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [recommendDetailCell.commentsButton addTarget:self action:@selector(commentsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [recommendDetailCell.heartButton addTarget:self action:@selector(heartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    recommendDetailCell.shareButton.tag = indexPath.row + 100;
    recommendDetailCell.commentsButton.tag = indexPath.row + 101;
    recommendDetailCell.heartButton.tag = indexPath.row + 102;
    
    return recommendDetailCell;
}

// 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecCellDetailViewController *recCellDetailVC = [[RecCellDetailViewController alloc] init];
    RecommendModel *model = self.dataArray[indexPath.row];
    recCellDetailVC.recModel = model;
    recCellDetailVC.navBarTitle = model.name;
    recCellDetailVC.esPlaceId = self.desModel.placeIdsArray[indexPath.row];
    
    [self.navigationController pushViewController:recCellDetailVC animated:YES];
}

// Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

// Header信息
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Max_Width, 50)];
    UILabel *label = [UILabel labelWithFrame:view.frame fontSize:17 lineBreak:0];
    label.text = @"相关旅行地信息";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}

// Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cellHeight;
}

#pragma mark ---- cell里的控件方法
// 分享
- (void)shareButtonAction:(UIButton *)sender {
    NSLog(@"分享");
}

// 评论
- (void)commentsButtonAction:(UIButton *)sender {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
    
        // 允许用户使用应用
        WriteCommentViewController *writeCommentVC = [[WriteCommentViewController alloc] init];
        writeCommentVC.esPlaceId = self.desModel.placeIdsArray[sender.tag - 101];
        
        [self.navigationController pushViewController:writeCommentVC animated:YES];
    } else {
        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        
//        [userDefaults setObject:@"RecCellDetailViewController" forKey:@"controller"];
//        
//        [userDefaults synchronize];
        
        //缓存用户对象为空时，可打开用户注册界面…
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)heartButtonAction:(UIButton *)senger {
    NSLog(@"点赞");
}

#pragma mark ---- 滑动设置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.bounces = NO;
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.recommendV.tableView.delegate = self;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.recommendV.tableView.delegate = nil;
}

#pragma mark --- 懒加载
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
