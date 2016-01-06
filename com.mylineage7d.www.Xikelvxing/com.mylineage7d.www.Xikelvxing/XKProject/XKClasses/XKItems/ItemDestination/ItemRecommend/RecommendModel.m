//
//  RecommendModel.m
//  XikeTest
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"name"]) {
        self.name = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"address"]) {
        self.address = [NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"main_pic"]) {
        self.main_pic = [NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"brief"]) {
        self.brief = [NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"comments"]) {
        self.comments = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"location"]) {
        self.location = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"likes"]) {
        self.likes = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"city_id"]) {
        self.city_id = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"openinghours"]) {
        self.openinghours = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"visits"]) {
        self.visits = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"region"]) {
        self.region = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"score"]) {
        self.score = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"localname"]) {
        self.localname = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"images"]) {
        self.images = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"type"]) {
        self.type = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"localaddress"]) {
        self.localaddress = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"phone"]) {
        self.phone = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"travel"]) {
        self.travel = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"cost"]) {
        self.cost = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"recommend"]) {
        self.recommend = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"comments"]) {
        self.commentsY = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"sub_type"]) {
        self.sub_type = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"marks"]) {
        self.marks = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"status"]) {
        self.status = [NSString stringWithFormat:@"%@",value];
    }
}

@end
