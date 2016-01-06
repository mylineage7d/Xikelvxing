//
//  DetailButtonViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DetailButtonViewController.h"
#import "DetailButtonViewCell.h"
#import "RecCellDetailViewController.h"

@interface DetailButtonViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)CGFloat cellHeight; // Cell高度

#pragma mark --- 传给接口
@property (nonatomic,strong)NSString *sub_type; // 类别
@property (nonatomic,strong)NSString *area; // 购物
@property (nonatomic,strong)NSString *sort; // 排序
@end

@implementation DetailButtonViewController

- (void)loadView{
    self.detailButtonV = [[DetailButtonView alloc] initWithFrame:Main_Screen];
    self.view = self.detailButtonV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置NavigationBar
    [self setNavBar];
    
    // 设置数据
    [self setData];

    // 设置Menu
    [self setMenuViews];
    
    // 设置TableView
    [self setTableView];
}

#pragma mark --- 设置TableView
- (void)setTableView{
    self.detailButtonV.tableView.dataSource = self;
    self.detailButtonV.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.detailButtonV.tableView registerClass:[DetailButtonViewCell class] forCellReuseIdentifier:cDetailButton_Cell];
}

#pragma mark --- 设置Menu
- (void)setMenuViews{

    self.categoryCateArray = @[@"类别",@"韩餐",@"中餐",@"快餐",@"西餐",@"日餐",@"自助餐",@"素食"];
    self.categoryShoppingArray = @[@"类别",@"免税店",@"购物潮街",@"百货公司",@"传统市场",@"跳蚤市场",@"美容&SPA"];
    self.categoryScenicSpotsArray = @[@"类别",@"热门地标",@"明星出没",@"大学校园",@"人文遗产",@"山川风光",@"博物馆/艺术展",@"娱乐休闲"];
    self.areaShouerArray = @[@"区域",@"明洞/南山",@"弘大",@"大学路/东大门",@"三清洞/仁寺洞",@"江南/蚕室",@"梨大/新村",@"林萌路",@"狎鸥亭/清潭洞",@"汝矣岛"];
    self.areaJizhoudaoArray = @[@"区域",@"济州市",@"西归浦市",@"中文旅游区",@"万丈窟/城山日出峰",@"翰林公园",@"汉拿山国立公园",@"林萌路",@"狎鸥亭/清潭洞",@"汝矣岛"];
    self.sortArray = @[@"排序",@"热度优先",@"距离优先"];

    self.detailButtonV.menu.dataSource = self;
}

#pragma mark ---- 设置NavigationBar
- (void)setNavBar{
    
    UIBarButtonItem *destinationButton = [[UIBarButtonItem alloc] initWithCustomView:self.detailButtonV.leftNavBarView];
    self.navigationItem.leftBarButtonItem = destinationButton;
    self.detailButtonV.leftNavBarView.navBarLabel.text = self.navBarTitle;
    
    [self.detailButtonV.leftNavBarView.tapNavBar addTarget:self action:@selector(tapLeftNavBarAction)];
    
#warning ---- 右NavBar少 分享 功能
    //    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:self.destinationV.searchButton];
    //    self.navigationItem.rightBarButtonItem = searchButton;
}

- (void)tapLeftNavBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 请求数据
- (void)setData{
    if (self.sub_type != nil || self.area != nil) {
        [JXDataMethod requestDataCity_id:self.city_id type:self.type sub_type:self.sub_type area:self.area sort:self.sort block:^(NSArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dataArray = (NSMutableArray *)array;
                [self.detailButtonV.tableView reloadData];
            });
        }];
    }
}

#pragma mark --- 设置Menu方法
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

// 第column列有多少行
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        if ([self.type isEqualToString:@"meishi"]) {
            return self.categoryCateArray.count;
        } else if ([self.type isEqualToString:@"gouwu"]){
            return self.categoryShoppingArray.count;
        } else {
            return self.categoryScenicSpotsArray.count;
        }
    }else if (column == 1){
        if ([self.city_id isEqualToString:@"shouer"]) {
            return self.areaShouerArray.count;
        } else {
            return self.areaJizhoudaoArray.count;
        }
    }else {
        return self.sortArray.count;
    }
}
// 第column列 每行title
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if ([self.type isEqualToString:@"meishi"]) {
            return self.categoryCateArray[indexPath.row];
        } else if ([self.type isEqualToString:@"gouwu"]){
            return self.categoryShoppingArray[indexPath.row];
        } else {
            return self.categoryScenicSpotsArray[indexPath.row];
        }
    }else if (indexPath.column == 1){
        if ([self.city_id isEqualToString:@"shouer"]) {
            return self.areaShouerArray[indexPath.row];
        } else {
            return self.areaJizhoudaoArray[indexPath.row];
        }
    }else {
        return self.sortArray[indexPath.row];
    }
}

// 点击代理
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if ([self.type isEqualToString:@"meishi"]) {
            self.sub_type = self.categoryCateArray[indexPath.row];
            if ([self.sub_type isEqualToString:@"类别"]) {
                self.sub_type = nil;
            }
        } else if ([self.type isEqualToString:@"gouwu"]){
            self.sub_type = self.categoryShoppingArray[indexPath.row];
            if ([self.sub_type isEqualToString:@"类别"]) {
                self.sub_type = nil;
            }
        } else {
            self.sub_type = self.categoryScenicSpotsArray[indexPath.row];
            if ([self.sub_type isEqualToString:@"类别"]) {
                self.sub_type = nil;
            }
        }
    }else if (indexPath.column == 1){
        if ([self.city_id isEqualToString:@"shouer"]) {
            self.area = self.areaShouerArray[indexPath.row];
            if ([self.area isEqualToString:@"区域"]) {
                self.area = nil;
            }
        } else {
            self.area = self.areaJizhoudaoArray[indexPath.row];
            if ([self.area isEqualToString:@"区域"]) {
                self.area = nil;
            }
        }
    }else {
        self.sort = self.sortArray[indexPath.row];
        if ([self.sort isEqualToString:@"排序"]) {
            self.sort = @"score";
        } else if ([self.sort isEqualToString:@"热度优先"]) {
            self.sort = @"score";
        } else if ([self.sort isEqualToString:@"距离优先"]) {
            self.sort = @"score";
        }
    }
    [self setData];
}

#pragma mark --- UITableView代理方法

// cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailButtonViewCell *detailButtonCell = [tableView dequeueReusableCellWithIdentifier:cDetailButton_Cell forIndexPath:indexPath];
//    detailButtonCell.selectionStyle = UITableViewCellSelectionStyleNone;
    RecommendModel *model = self.dataArray[indexPath.row];
    detailButtonCell.model = model;
    self.cellHeight = detailButtonCell.cellHeight;
    
    detailButtonCell.type.text = [NSString stringWithFormat:@"%@/%@",self.area,self.sub_type];
    
    return detailButtonCell;
}
// 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cellHeight;
}

// cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecCellDetailViewController *recCellDetailVC = [[RecCellDetailViewController alloc] init];
    RecommendModel *model = self.dataArray[indexPath.row];
    recCellDetailVC.recModel = model;
    recCellDetailVC.navBarTitle = model.name;
    
    [self.navigationController pushViewController:recCellDetailVC animated:YES];
    
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.detailButtonV.menu.delegate = self;
    self.detailButtonV.tableView.delegate = self;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.detailButtonV.menu.delegate = nil;
    self.detailButtonV.tableView.delegate = nil;
}

#pragma mark --- 懒加载
- (void)setCity_id:(NSString *)city_id{
    
    _city_id = city_id;
}

- (void)setType:(NSString *)type{
    _type = type;
}

- (NSString *)sort{
    if (_sort == nil) {
        _sort = @"score";
    }
    return _sort;
}

//- (NSString *)area{
//    if (_area == nil) {
////        _area = @"明洞/南山";
//    }
//    return _area;
//}

//- (NSString *)sub_type{
//    if (_sub_type == nil){
////        _sub_type = @"韩餐";
//    }
//    return _sub_type;
//}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        [JXDataMethod requestData:nil block:^(NSArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _dataArray = (NSMutableArray *)array;
                [self.detailButtonV.tableView reloadData];
            });
        }];
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
