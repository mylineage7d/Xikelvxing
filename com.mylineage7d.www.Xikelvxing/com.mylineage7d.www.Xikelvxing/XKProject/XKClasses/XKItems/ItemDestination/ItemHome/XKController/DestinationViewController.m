//
//  DestinationViewController.m
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DestinationViewController.h"
#import "ButtonTableViewCell.h"
#import "RecommendTableViewCell.h"
#import "DestinationModel.h"
#import "selectViewController.h"
#import "RecommendViewController.h"
#import "DetailButtonViewController.h"

@interface DestinationViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLLocation *_checkinLocation;
}
@property (nonatomic,assign)CGFloat cellHeight1;
@property (nonatomic,assign)CGFloat cellHeight2;
@end

@implementation DestinationViewController

- (void)loadView{
    self.destinationV = [[DestinationView alloc] initWithFrame:Main_Screen];
    self.view = self.destinationV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置定位
    [self setLocation];
    
    // 设置数据
    [self setDataSource];
    
    // 设置tableView
    [self setTableView];
    
    // 设置NavigationBar
    [self setNavBar];
    
    // View赋值
    [self setViews];
   
}

#pragma mark ---- 设置定位
- (void)setLocation {
    
    //定位管理器
    _locationManager = [[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
        
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        
        //设置代理
        _locationManager.delegate = self;
        
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 20.0;//十米定位一次
        _locationManager.distanceFilter = distance;
        
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark ---- CLLocationManagerDelegate 代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    _checkinLocation = newLocation;
}

#pragma mark ---- 设置数据
- (void)setDataSource{
    [JXDataMethod requestDataClassName:@"Push" whereKey:@"cityId" equalTo:self.cityLable block:^(NSArray * array) {
        self.arrayData = (NSMutableArray *)array;
        [self.destinationV.tableView reloadData];
    }];
}

#pragma mark --- View赋值
- (void)setViews{
    if ([self.cityLable isEqualToString:@"shouer"]) {
        self.destinationV.cityV.image = [UIImage imageNamed:@"city_cover_shouer_sketch"];
        self.destinationV.cityLabel.text = @"首尔";
    } else if ([self.cityLable isEqualToString:@"jizhoudao"]){
        self.destinationV.cityV.image = [UIImage imageNamed:@"city_jizhoudao_sketch"];
        self.destinationV.cityLabel.text = @"济州岛";
    }
    [self.destinationV.cityLabel sizeToFit];
    [Tools setLabelCenter:self.destinationV.cityLabel originX:Image_Width / 2 originY:Image_Height / 2];
}

#pragma mark ---- 设置tableView
- (void)setTableView{
    self.destinationV.tableView.tableHeaderView = self.destinationV.cityV;

    // 设置代理
    self.destinationV.tableView.dataSource = self;
    
    // Cell注册
    [self.destinationV.tableView registerClass:[ButtonTableViewCell class] forCellReuseIdentifier:cButtonTableView_Cell];
    [self.destinationV.tableView registerClass:[RecommendTableViewCell class] forCellReuseIdentifier:cRecommendTableView_Cell];
}

#pragma mark ---- 设置NavigationBar
- (void)setNavBar{
    // 按钮方法
    [self.destinationV.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.destinationV.leftNavBarView.tapNavBar addTarget:self action:@selector(tapLeftNavBarAction)];
    
    // 设置BarButton按钮
    UIBarButtonItem *destinationButton = [[UIBarButtonItem alloc] initWithCustomView:self.destinationV.leftNavBarView];
    self.navigationItem.leftBarButtonItem = destinationButton;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:self.destinationV.searchButton];
    self.navigationItem.rightBarButtonItem = searchButton;
}

- (void)tapLeftNavBarAction{
    selectViewController *selectVC = [[selectViewController alloc] init];
    
    __weak DestinationViewController *weakSelf = self;
    [selectVC sendMessage:^(NSString *str) {
        if (weakSelf.cityLable != str) {
            weakSelf.cityLable = str;
            [self setDataSource];
            [self setViews];
        }
    }];

    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:selectVC animated:NO];
}

// 搜索方法
- (void)searchButtonAction:(UIBarButtonItem *)sender{
    NSLog(@"搜索");
    
    [_locationManager startUpdatingLocation];
    NSLog(@"经度：%f,纬度：%f",_checkinLocation.coordinate.longitude,_checkinLocation.coordinate.latitude);
    [_locationManager stopUpdatingLocation];
}


#pragma mark ---- UITableViewDataSource代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.arrayData) {
        return 1;
    } else {
        return self.arrayData.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ButtonTableViewCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:cButtonTableView_Cell forIndexPath:indexPath];
        buttonCell.selectionStyle = UITableViewCellSelectionStyleNone;
        buttonCell.backgroundColor = TableView_Color;
        
        // 按钮点击方法
        [buttonCell.cateButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell.shoppingButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell.scenicSpotsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        self.cellHeight1 = buttonCell.cellHeight;
        
        return buttonCell;
    } else {
        RecommendTableViewCell *reconmendCell = [tableView dequeueReusableCellWithIdentifier:cRecommendTableView_Cell forIndexPath:indexPath];
        reconmendCell.backgroundColor = TableView_Color;
        DestinationModel *model = self.arrayData[indexPath.row - 1];
        reconmendCell.destinationModel = model;
        
        // Cell高度
        self.cellHeight2 = reconmendCell.cellHeight;
        
        return reconmendCell;
    }
}
// buttonCell里的按钮方法
- (void)buttonAction:(UIButton *)sender{
    
    DetailButtonViewController *detailButtonVC = [[DetailButtonViewController alloc] init];
    
    detailButtonVC.city_id = self.cityLable;
    
    if (sender.tag == 201){
        detailButtonVC.type = @"meishi";
        detailButtonVC.navBarTitle = @"美食";
    } else if (sender.tag == 202) {
        detailButtonVC.type = @"gouwu";
        detailButtonVC.navBarTitle = @"购物";
    } else if (sender.tag == 203) {
        detailButtonVC.type = @"jingdian";
        detailButtonVC.navBarTitle = @"景点";
    }

    
    [self.navigationController pushViewController:detailButtonVC animated:YES];
}

// 设置Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0){
        return self.cellHeight1;
    } else {
        return self.cellHeight2;
    }
}

// Cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
    
    } else {
        RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
        DestinationModel *model = self.arrayData[indexPath.row - 1];
        recommendVC.desModel = model;
        [self.navigationController pushViewController:recommendVC animated:YES];
    }
}

#pragma mark --- NavBar隐藏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self.destinationV.leftNavBarView.navBarLabel setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:alpha]];
            if ([self.cityLable isEqualToString:@"shouer"]) {
                self.destinationV.leftNavBarView.navBarLabel.text = @"首尔";
                self.destinationV.leftNavBarView.navBarLabel.textColor = [UIColor blackColor];
            } else if ([self.cityLable isEqualToString:@"jizhoudao"]){

                self.destinationV.leftNavBarView.navBarLabel.text = @"济州岛";
                self.destinationV.leftNavBarView.navBarLabel.textColor = [UIColor blackColor];
            }
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.destinationV.leftNavBarView.navBarLabel.text = @"目的地";
        [self.destinationV.leftNavBarView.navBarLabel setTextColor:[UIColor whiteColor]];
    }
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.destinationV.tableView.delegate = self;
    self.tabBarController.tabBar.hidden = NO;
    UIColor * color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.destinationV.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark --- 懒加载
- (NSMutableArray *)arrayData{
    if (_arrayData == nil) {
        _arrayData = [[NSMutableArray alloc] init];
    }
    return _arrayData;
}

- (NSString *)cityLable{
    if (_cityLable == nil) {
        _cityLable = @"shouer";
    }
    return _cityLable;
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

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

@end
