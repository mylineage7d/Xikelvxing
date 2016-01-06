//
//  DiscoverModel.m
//  XikeTest
//
//  Created by lanou3g on 15/12/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"updatedAt"]) {
        self.updatedAt = [NSString stringWithFormat:@"%f", [value timeIntervalSince1970]];
    }
    if ([key isEqualToString:@"createdAt"]) {
        self.createdAt = [NSString stringWithFormat:@"%f", [value timeIntervalSince1970]];
    }
    if ([key isEqualToString:@"content"]) {
        self.content = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"comments"]) {
        self.comments = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"likes"]) {
        self.likes = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"isHot"]) {
        self.isHot = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"seq"]) {
        self.seq = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"enable"]) {
        self.enable = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"userId"]) {
        self.userId = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"objectId"]) {
        self.objectId = [NSString stringWithFormat:@"%@",value];
    }
}
@end
