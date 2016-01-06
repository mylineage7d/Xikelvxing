//
//  RecCellDetailViewController.m
//  XikeTest
//
//  Created by lanou3g on 15/11/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecCellDetailViewController.h"
#import "RecButtonVIewCell.h"
#import "RecAddressAndPathCell.h"
#import "WriteCommentViewController.h"
#import "LoginViewController.h"
#import "RecCommentCell.h"
#import "ErrorCorrectionViewController.h"
@interface RecCellDetailViewController ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)NSMutableArray *commentArray;
@end

@implementation RecCellDetailViewController

- (void)loadView{
    self.cellDetailV = [[RecCellDetailView alloc] initWithFrame:Main_Screen];
    self.view = self.cellDetailV;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置头视图数据
    [self setData];
    
    // 设置评论数据
//    [self setCommentData];
    
    // 设置tableView
    [self setTableView];
}

#pragma mark ---- 设置评论数据
- (void)setCommentData {
    AVQuery *query = [AVQuery queryWithClassName:@"PlaceComment"];
    [query whereKey:@"esPlaceId" equalTo:self.esPlaceId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            self.commentArray = [NSMutableArray arrayWithArray:objects];
            [self.cellDetailV.tableView reloadData];
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark --- 设置头视图数据
- (void)setData{
    if (!self.recModel) {
        NSLog(@"为空啊");
        return;
    }
    
    [self.cellDetailV.main_pic sd_setImageWithURL:[NSURL URLWithString:self.recModel.main_pic]];
    
    self.cellDetailV.name.text = self.recModel.name;
    [Tools setLabelOrigin:self.cellDetailV.name originX:10 originY:CGRectGetMaxY(self.cellDetailV.headButton.frame)];
    
    self.cellDetailV.localname.text = self.recModel.localname;
    [Tools setLabelOrigin:self.cellDetailV.localname originX:self.cellDetailV.name.frame.origin.x originY:CGRectGetMaxY(self.cellDetailV.name.frame) + 3];
    
    NSString *str = self.recModel.brief;
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    
    self.cellDetailV.brief.text = str4;
    [Tools setLabelHeight:self.cellDetailV.brief text:str4 fontSize:16];
    if (self.cellDetailV.brief.text.length == 0) {
        self.cellDetailV.introduce.text = @"";
        self.cellDetailV.introduce.frame = CGRectMake(self.cellDetailV.name.frame.origin.x, CGRectGetMaxY(self.cellDetailV.localname.frame) + 10, self.cellDetailV.name.frame.size.width, 0);
        self.cellDetailV.brief.frame = CGRectMake(10, CGRectGetMaxY(self.cellDetailV.introduce.frame), self.cellDetailV.name.frame.size.width, 0);
    }
    
    CGRect rect3 = self.cellDetailV.headV.frame;
    
    rect3.size.height = self.cellDetailV.main_pic.frame.size.height + + self.cellDetailV.headButton.frame.size.height / 2 + self.cellDetailV.name.frame.size.height + self.cellDetailV.localname.frame.size.height + self.cellDetailV.introduce.frame.size.height + self.cellDetailV.brief.frame.size.height + 10;
    self.cellDetailV.headV.frame = rect3;
}

#pragma mark --- 设置tableView
-(void)setTableView{
    self.cellDetailV.tableView.tableHeaderView = self.cellDetailV.headV;
    self.cellDetailV.tableView.dataSource = self;
    self.cellDetailV.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Cell注册
    [self.cellDetailV.tableView registerClass:[RecButtonVIewCell class] forCellReuseIdentifier:cRecButtonView_Cell];
    [self.cellDetailV.tableView registerClass:[RecAddressAndPathCell class] forCellReuseIdentifier:cRecAddressAndPath_Cell];
    [self.cellDetailV.tableView registerClass:[RecCommentCell class] forCellReuseIdentifier:cRecComment_Cell];
}

#pragma mark --- UITableView代理方法
// cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else {
        return self.commentArray.count;
    }
}

// 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RecButtonVIewCell *recButtonCell = [tableView dequeueReusableCellWithIdentifier:cRecButtonView_Cell forIndexPath:indexPath];
            recButtonCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [recButtonCell.uploadPicturesButton addTarget:self action:@selector(uploadPicturesButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [recButtonCell.writeCommentButton addTarget:self action:@selector(writeCommentButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [recButtonCell.errorCorrectionButton addTarget:self action:@selector(errorCorrectionButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [recButtonCell.shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
            self.cellHeight1 = recButtonCell.cellHeight;
            return recButtonCell;
        } else {
            RecAddressAndPathCell *recAddressAndPathCell = [tableView dequeueReusableCellWithIdentifier:cRecAddressAndPath_Cell forIndexPath:indexPath];
            recAddressAndPathCell.selectionStyle = UITableViewCellSelectionStyleNone;
            RecommendModel *model = self.recModel;
            recAddressAndPathCell.model = model;
            
            self.cellHeight2 = recAddressAndPathCell.cellHeight;
            return recAddressAndPathCell;
        }
    } else {
        RecCommentCell *recCommentCell = [tableView dequeueReusableCellWithIdentifier:cRecComment_Cell forIndexPath:indexPath];
        recCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        recCommentCell.post = self.commentArray[indexPath.row];
        
        self.cellHeight3 = recCommentCell.cellHeight;
        return recCommentCell;
    }
}

// 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            return self.cellHeight1;
        } else {
            return self.cellHeight2;
        }
    } else {
        return self.cellHeight3;
    }
}

// tableView组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    } else {
        if (self.commentArray.count == 0) {
            return 0.1;
        } else {
            return 40;
        }
    }
}

// Header信息
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    } else {
        
        if (self.commentArray.count == 0) {
            return nil;
        } else {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Max_Width, 25)];
            UILabel *label = [UILabel labelWithFrame:view.frame fontSize:17 lineBreak:0];
            label.text = @"用户评论";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            return view;
        }
    }
}

#pragma mark ---- 设置滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.bounces = NO;
}

#pragma mark ---- 按钮方法
// 上传照片
- (void)uploadPicturesButtonAction {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing = YES;
    
    // 进入的样式
    //    imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 只能用模态 进入相册
    [self presentViewController:imagePicker animated:YES completion:^{
        //        NSLog(@"进入相册");
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSLog(@"你出来啊");
    
    // UIImagePickerControllerOriginalImage 保存原图
    // UIImagePickerControllerEditedImage 保存编辑后的图片
    
    //    _imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// 写评论
- (void)writeCommentButtonAction {
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
    
        // 允许用户使用应用
        WriteCommentViewController *writeCommentVC = [[WriteCommentViewController alloc] init];
        writeCommentVC.esPlaceId = self.esPlaceId;
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

// 纠错
- (void)errorCorrectionButtonAction {
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        
        // 允许用户使用应用
        ErrorCorrectionViewController *errorVC = [[ErrorCorrectionViewController alloc] init];
        errorVC.esPlaceId = self.esPlaceId;
        [self.navigationController pushViewController:errorVC animated:YES];
    } else {
        
        //缓存用户对象为空时，可打开用户注册界面…
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

// 分享方法
- (void)shareButtonAction {
    
}

#pragma mark --- 懒加载
- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [[NSMutableArray alloc] init];
    }
    return _commentArray;
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.cellDetailV.tableView.delegate = self;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.cellDetailV.tableView.delegate = nil;
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
