//
//  NewViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/12/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "NewViewController.h"
#import "DiscoverTableViewCell.h"
#import "MJRefresh.h"
#import "DiscoverDetailViewController.h"
#import "WriteCommentViewController.h"
#import "LoginViewController.h"
@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) AVQuery *query;

@end

@implementation NewViewController

- (void)loadView{
    self.discoverV = [[DiscoverView alloc] initWithFrame:Main_Screen];
    self.view = self.discoverV;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 设置数据(上拉下拉刷新)
    [self setupRefresh];
    
    // 设置tableView
    [self setTableView];
}

#pragma mark --- 设置tableView
- (void)setTableView{
    self.discoverV.tableView.dataSource = self;
    self.discoverV.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Cell注册
    [self.discoverV.tableView registerClass:[DiscoverTableViewCell class] forCellReuseIdentifier:cDiscover_Cell];
}

#pragma mark ---- 上拉下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.discoverV.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 自动刷新(一进入程序就下拉刷新)
    [self.discoverV.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.discoverV.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.discoverV.tableView.headerPullToRefreshText = @"可以刷新了~";
    self.discoverV.tableView.headerReleaseToRefreshText = @"马上刷新~";
    self.discoverV.tableView.headerRefreshingText = @"正在刷新中~";
    
    self.discoverV.tableView.footerPullToRefreshText = @"加载更多数据~";
    self.discoverV.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据~";
    self.discoverV.tableView.footerRefreshingText = @"正在帮你加载中~";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing {
    // 加载新数据
    self.query = [AVQuery queryWithClassName:@"Moment"];
    [self.query whereKey:@"isHot" equalTo:@(NO)];
    [self.query orderByDescending:@"createdAt"];
    self.query.limit = 8;
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.dataArray removeAllObjects];
            for (AVObject *ob in objects) {
                NSMutableDictionary *dic = [ob objectForKey:@"localData"];
                
                DiscoverModel *model = [[DiscoverModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                model.updatedAt = ob[@"updatedAt"];
                model.createdAt = ob[@"createdAt"];
                model.objectId = ob[@"objectId"];
                model.imageUrls = [dic objectForKey:@"imageUrls"];
                model.location = [dic objectForKey:@"location"];

                AVQuery *query = [AVQuery queryWithClassName:@"_User"];
                AVObject *user = [query getObjectWithId:[dic objectForKey:@"userId"]];
                model.username = user[@"username"];
                model.avatarUrl = user[@"avatarUrl"];
                
                UILabel *content = [[UILabel alloc] init];
                content.frame = CGRectMake(0,0, Max_Width - 20, 16);
                content.textAlignment = NSTextAlignmentCenter;
                content.text = model.content;
                [Tools setLabelHeight:content text:content.text fontSize:16];
                model.cellHeight = [NSString stringWithFormat:@"%f",Top_Offset(10) + Button_Size + 10 + Image_Height + 10 + content.frame.size.height + 10 + 17 + 10];
                
                [self.dataArray addObject:model];
                
            }
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.discoverV.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.discoverV.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 再刷新数据
    [self.query whereKey:@"isHot" equalTo:@(NO)];
    self.query.limit = 8;
    self.query.skip = self.dataArray.count;
    [self.query orderByDescending:@"createdAt"];
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (AVObject *ob in objects) {
                NSMutableDictionary *dic = [ob objectForKey:@"localData"];
                DiscoverModel *model = [[DiscoverModel alloc] init];
                model.updatedAt = ob[@"updatedAt"];
                model.createdAt = ob[@"createdAt"];
                model.objectId = ob[@"objectId"];
                model.imageUrls = [dic objectForKey:@"imageUrls"];
                model.location = [dic objectForKey:@"location"];
                
                [model setValuesForKeysWithDictionary:dic];
                
                AVQuery *query = [AVQuery queryWithClassName:@"_User"];
                AVObject *user = [query getObjectWithId:[dic objectForKey:@"userId"]];
                model.username = user[@"username"];
                model.avatarUrl = user[@"avatarUrl"];
                
                UILabel *content = [[UILabel alloc] init];
                content.frame = CGRectMake(0,0, Max_Width - 20, 16);
                content.textAlignment = NSTextAlignmentCenter;
                content.text = model.content;
                [Tools setLabelHeight:content text:content.text fontSize:16];
                model.cellHeight = [NSString stringWithFormat:@"%f",Top_Offset(10) + Button_Size + 10 + Image_Height + 10 + content.frame.size.height + 10 + 17 + 10];
                
                [self.dataArray addObject:model];
                
            }
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.discoverV.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.discoverV.tableView footerEndRefreshing];
    });
}

#pragma mark ---- UITableViewDataSource代理方法
// cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverTableViewCell *discoverCell = [tableView dequeueReusableCellWithIdentifier:cDiscover_Cell forIndexPath:indexPath];
    discoverCell.selectionStyle = UITableViewCellSelectionStyleNone;
    discoverCell.backgroundColor = TableView_Color;
    DiscoverModel *model = self.dataArray[indexPath.row];
    discoverCell.disModel = model;
    discoverCell.index = indexPath.row;
    
    [discoverCell.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [discoverCell.commentsButton addTarget:self action:@selector(commentsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [discoverCell.heartButton addTarget:self action:@selector(heartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    discoverCell.shareButton.tag = indexPath.row + 106;
    discoverCell.commentsButton.tag = indexPath.row + 107;
    discoverCell.heartButton.tag = indexPath.row + 108;
    
//    discoverCell.num.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return discoverCell;
}

// 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
    
    discoverDetailVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:discoverDetailVC animated:YES];
}

// Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverModel *model = self.dataArray[indexPath.row];
    return [model.cellHeight floatValue];
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
        //        writeCommentVC.esPlaceId = self.desModel.placeIdsArray[sender.tag - 104];
        
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


#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.discoverV.tableView.delegate = self;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    //    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.discoverV.tableView.delegate = nil;
}

#pragma mark --- 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
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
