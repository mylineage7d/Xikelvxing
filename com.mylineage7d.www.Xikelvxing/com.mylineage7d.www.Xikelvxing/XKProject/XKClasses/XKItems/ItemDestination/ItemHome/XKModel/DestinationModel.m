//
//  DestinationModel.m
//  XikeTest
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"marks"]) {
        self.marks = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"visits"]) {
        self.visits = [NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"imageUrl"]) {
        self.imageUrl = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"content"]) {
        self.content = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"title"]) {
        self.title = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"status"]) {
        self.status = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"objectId"]) {
        self.objectId = [NSString stringWithFormat:@"%@",value];
    }
}

@end
