//
//  CurrentLocation.h
//  com.mylineage7d.www.Xikelvxing
//
//  Created by Mylineag7d on 16/1/5.
//  Copyright © 2016年 Mylineag7d. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentLocation : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic, strong)CLLocation *location;
+ (CurrentLocation *)shareCurrentLocation;

- (void)startLocation;
- (void)stopLocation;
@end
