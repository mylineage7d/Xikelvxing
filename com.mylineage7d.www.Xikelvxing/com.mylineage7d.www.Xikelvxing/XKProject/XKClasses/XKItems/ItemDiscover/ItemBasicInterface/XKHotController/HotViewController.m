//
//  HotViewController.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/23.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "HotViewController.h"
#import "MJRefresh.h"
#import "DiscoverDetailViewController.h"
#import "DiscoverTableViewCell.h"
#import "LoginViewController.h"
#import "WriteCommentViewController.h"

@interface HotViewController ()<UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate>
@property (nonatomic, strong) AVQuery *query;
@end

@implementation HotViewController

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
    [self.discoverV.tableView registerClass:[DiscoverTableViewCell class] forCellReuseIdentifier:cDiscoverViewTableView_Cell];
}

#pragma mark ---- 设置数据(上拉下拉刷新)
- (void)setupRefresh
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    self.discoverV.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRereshing];
    }];
    
    [self.discoverV.tableView.mj_header beginRefreshing];
    
    self.discoverV.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerRereshing];
    }];
}

#pragma mark ---- 开始进入刷新状态
- (void)headerRereshing {
    
    // 加载新数据
    self.query = [AVQuery queryWithClassName:@"Moment"];
    [self.query whereKey:@"isHot" equalTo:@(YES)];
    [self.query orderByDescending:@"createdAt"];
    self.query.limit = 8;
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.dataArray removeAllObjects];
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
        [self.discoverV.tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 再刷新数据
    [self.query whereKey:@"isHot" equalTo:@(YES)];
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
        [self.discoverV.tableView.mj_footer endRefreshing];
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
    DiscoverTableViewCell *newDiscoverCell = [tableView dequeueReusableCellWithIdentifier:cDiscoverViewTableView_Cell forIndexPath:indexPath];
    newDiscoverCell.selectionStyle = UITableViewCellSelectionStyleNone;
    newDiscoverCell.backgroundColor = TableView_Color;
    
    DiscoverModel *model = self.dataArray[indexPath.row];
    newDiscoverCell.disModel = model;
    newDiscoverCell.index = indexPath.row;
    
    [newDiscoverCell.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [newDiscoverCell.commentsButton addTarget:self action:@selector(commentsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [newDiscoverCell.heartButton addTarget:self action:@selector(heartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    newDiscoverCell.shareButton.tag = indexPath.row + 103;
    newDiscoverCell.commentsButton.tag = indexPath.row + 104;
    newDiscoverCell.heartButton.tag = indexPath.row + 105;
    
    return newDiscoverCell;
}

// cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverDetailViewController *discoverDetailVC = [[DiscoverDetailViewController alloc] init];
    
    discoverDetailVC.model = self.dataArray[indexPath.row];
    
    // 设置点赞状态
    [discoverDetailVC sendLikeStatus:^(BOOL status) {
        DiscoverTableViewCell *cell = [self.discoverV.tableView cellForRowAtIndexPath:indexPath];
        
        NSLog(@"status:%d",status);
        
        if (status) {
            cell.heartButton.selected = YES;
            [cell.heartButton setImage:[UIImage imageNamed:@"item_action_like_fill_sketch"] forState:UIControlStateNormal];
        } else {
            cell.heartButton.selected = NO;
            [cell.heartButton setImage:[UIImage imageNamed:@"item_action_like_sketch"] forState:UIControlStateNormal];
        }
    }];
    
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
    
    AVUser *user = [AVUser currentUser];
    
    if (user != nil) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"5662a16f67e58e8237000507"
                                          shareText:@"稀客旅行"
                                         shareImage:[UIImage imageNamed:@"icon"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,nil]
                                           delegate:self];
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"请先登录"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

// 友盟代理方法
-(BOOL)isDirectShareInIconActionSheet {
    return YES;
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
        
        //缓存用户对象为空时，可打开用户注册界面…
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"请先登录"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    NSLog(@"1");
}

// 点赞
- (void)heartButtonAction:(UIButton *)sender {
    
    AVUser *user = [AVUser currentUser];
//    NSLog(@"userId:%@",user.objectId);
    
    DiscoverModel *model = self.dataArray[sender.tag - 105];
    
    if (user != nil) {
        
        if (sender.selected == NO) {
            sender.selected = YES;
            [sender setImage:[UIImage imageNamed:@"item_action_like_fill_sketch"] forState:UIControlStateNormal];
            
            AVObject *post = [AVObject objectWithClassName:@"MomentLike"];
            [post setObject:model.objectId forKey:@"momentId"];
            [post setObject:user.objectId forKey:@"userId"];
            [post save];
            
            [self.discoverV.tableView reloadData];
            
        } else {
            sender.selected = NO;
            [sender setImage:[UIImage imageNamed:@"item_action_like_sketch"] forState:UIControlStateNormal];
            
            AVQuery *query = [AVQuery queryWithClassName:@"MomentLike"];
            [query whereKey:@"userId" equalTo:user.objectId];
            [query whereKey:@"momentId" equalTo:model.objectId];
            [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
                [object deleteInBackground];
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.discoverV.tableView reloadData];
            });
            
        }
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"请先登录"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
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
