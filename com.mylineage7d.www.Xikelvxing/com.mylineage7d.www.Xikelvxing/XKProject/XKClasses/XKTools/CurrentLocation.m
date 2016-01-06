//
//  CurrentLocation.m
//  com.mylineage7d.www.Xikelvxing
//
//  Created by Mylineag7d on 16/1/5.
//  Copyright © 2016年 Mylineag7d. All rights reserved.
//

#import "CurrentLocation.h"

@implementation CurrentLocation

static CurrentLocation *curLocation = nil;
+ (CurrentLocation *)shareCurrentLocation {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        curLocation = [[self alloc] init];
        [curLocation setLocation];
    });
    return curLocation;
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
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
        
//    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        
        //设置代理
        _locationManager.delegate = self;
        
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 20.0;//十米定位一次
        _locationManager.distanceFilter = distance;
        
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
//    }
}

#pragma mark ---- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    self.location = newLocation;
}

- (void)startLocation {
    [_locationManager startUpdatingLocation];
}

- (void)stopLocation {
    [_locationManager stopUpdatingLocation];
    
}

- (CLLocation *)location {
    if (!_location) {
        _location = [[CLLocation alloc] init];
    }
    return _location;
}
@end
