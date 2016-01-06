//
//  UploadViewController.m
//  xikelvxing
//
//  Created by Mylineag7d on 15/12/28.
//  Copyright © 2015年 Mylineag7d. All rights reserved.
//

#import "UploadViewController.h"
#import "ErrorCorrectionCell.h"
#import "AddCollectionViewCell.h"
#import "ZYQAssetPickerController.h"
#import <CoreLocation/CoreLocation.h>
@interface UploadViewController ()<UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ZYQAssetPickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLLocation *_checkinLocation;
}
@property (nonatomic, strong)NSMutableArray *imageArray;
@end

@implementation UploadViewController

- (void)loadView {
    self.uploadV = [[UploadView alloc] initWithFrame:Main_Screen];
    self.view = self.uploadV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置定位
    [self setLocation];
    
    // 设置NavBar
    [self setNavBar];
    
    // 设置CollectionView
    [self setCollectionView];
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
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        
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

#pragma mark ---- 屏幕触摸方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.uploadV.textView resignFirstResponder];
}

#pragma mark ---- 设置CollectionView
- (void)setCollectionView {
    self.uploadV.collectionView.dataSource = self;
    [self.uploadV.collectionView registerClass:[ErrorCorrectionCell class] forCellWithReuseIdentifier:cUploadViewController_Cell];
    [self.uploadV.collectionView registerClass:[AddCollectionViewCell class] forCellWithReuseIdentifier:cUploadAddViewController_Cell];
}

#pragma mark ---- UICollectionView 代理方法
// 返回每个分组有多少个单元
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count + 1;
}

// 返回每个单元
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ErrorCorrectionCell *errorCorrectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cUploadViewController_Cell forIndexPath:indexPath];
    AddCollectionViewCell *addCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cUploadAddViewController_Cell forIndexPath:indexPath];
    
    [addCollectionCell.button addTarget:self action:@selector(addCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.imageArray.count == 0) {
        
        return addCollectionCell;
    } else if (indexPath.row < self.imageArray.count) {
        
        ALAsset *asset = self.imageArray[indexPath.row];
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [errorCorrectionCell.imV setImage:tempImg];
        return errorCorrectionCell;
    } else {
        
        return addCollectionCell;
    }
}

// 添加图片
- (void)addCollectionAction:(UIButton *)sender {
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (id ob in assets) {
                [self.imageArray addObject:ob];
            }
            
            [self.uploadV.collectionView reloadData];
        });
    });
}

// 点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_locationManager startUpdatingLocation];
    NSLog(@"1经度：%f,纬度：%f",_checkinLocation.coordinate.longitude,_checkinLocation.coordinate.latitude);
    [_locationManager stopUpdatingLocation];
}

#pragma mark ---- UITextView代理方法
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.uploadV.label.text = @"说一说此刻的感受...";
    } else {
        self.uploadV.label.text = @"";
    }
}

#pragma mark ---- 设置NavBar
- (void)setNavBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_send_light_sketch"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

// 上传数据
- (void)rightBarButtonAction {
    
    AVUser *currentUser = [AVUser currentUser];
    
    // 判断用户
    if (currentUser != nil) {
        
        // 判断内容
        if (self.uploadV.textView.text.length != 0) {
            
            // 判断图片
            if (self.imageArray.count != 0) {
                
                // 请求token
                NSURL *url = [NSURL URLWithString:@"https://com-cjker-trip-api.shushuo.com/v1/upload_token"];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                request.HTTPMethod = @"POST";
                
                NSNumber *number = [NSNumber numberWithFloat:self.imageArray.count];
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:number forKey:@"number"];
                [dic setValue:currentUser.objectId forKey:@"userId"];
                
                NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
                NSString *bodyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                // 配置用户名 密码
                NSString * str = [NSString stringWithFormat:@"%@:%@",@"client",@"c31b32364ce19ca8fcd150a417ecce58"];
                // 进行加密  [str base64EncodedString]使用开源Base64.h分类文件加密
                NSString * str2 = [NSString stringWithFormat:@"Basic %@",[Base64 base64StringFromText:str]];
                [request setValue:str2 forHTTPHeaderField:@"Authorization"];
                [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                
                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (data != nil) {
                        NSArray *tokenArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        
                        NSLog(@"tokenArr:%@",tokenArray);
                        
                        // 图片地址
                        NSMutableArray *placeArray = [[NSMutableArray alloc] init];
                        
                        // 文件管理者
                        NSFileManager *manager = [NSFileManager defaultManager];
                        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                        NSLog(@"doc:%@",doc);
                        
                        for (int i = 0; i < self.imageArray.count; i++) {
                            
                            ALAsset *asset = self.imageArray[i];
                            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                            
                            // 图片压缩
                            NSData *imageData = UIImageJPEGRepresentation(tempImg, 0.5);
                            
                            // 获取uuid
                            CFUUIDRef puuid = CFUUIDCreate( nil );
                            CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
                            NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
                            
                            // 图片存储到沙盒
                            NSString *imageName = [NSString stringWithFormat:@"%@.png",result];
                            NSString * path = [doc stringByAppendingPathComponent:imageName];
                            [imageData writeToFile:path atomically:NO];
                            
                            NSData *imageData2 = [NSData dataWithContentsOfFile:path];
                            
                            NSDictionary *dic = tokenArray[i];
                            NSString *key = [dic objectForKey:@"key"];
                            NSString *token = [dic objectForKey:@"token"];
                            
                            // 上传到七牛
                            QNUploadManager *upManager = [[QNUploadManager alloc] init];
                            
                            [upManager putData:imageData2 key:key token:token
                                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                                          NSLog(@"%@", info);
//                                          NSLog(@"%@", resp);
    
                                      } option:nil];
                            
                            CFRelease(puuid);
                            CFRelease(uuidString);
                            
                            // 删除沙盒图片
                            [manager removeItemAtPath:path error:nil];
                            
                            NSString *place = [NSString stringWithFormat:@"http://7xlr8g.com1.z0.glb.clouddn.com/%@",key];
                            
                            [placeArray addObject:place];
                        }
                        
                        // 上传到LeanCloud
                        AVObject *post = [AVObject objectWithClassName:@"Moment"];
                        
                        [post setObject:self.uploadV.textView.text forKey:@"content"];
                        [post setObject:currentUser.objectId forKey:@"userId"];
                        [post setObject:placeArray forKey:@"imageUrls"];
                        
                        [_locationManager startUpdatingLocation];
                        NSLog(@"经度：%f,纬度：%f",_checkinLocation.coordinate.longitude,_checkinLocation.coordinate.latitude);
                        AVGeoPoint *point = [AVGeoPoint geoPointWithLatitude:_checkinLocation.coordinate.latitude longitude:_checkinLocation.coordinate.longitude];
                        
                        [_locationManager stopUpdatingLocation];
                        [post setObject:point forKey:@"location"];
                        [post save];
                        
                    }
                    NSLog(@"error:%@",error);
                }];
                
                [task resume];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:@"上传成功"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];

            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:@"图片不能为空"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"内容不能为空"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"请先登录"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark ---- ViewAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.uploadV.textView.delegate = self;
    self.uploadV.collectionView.delegate = self;
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBar_Color colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.uploadV.textView.delegate = nil;
    self.uploadV.collectionView.delegate = nil;
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
