//
//  JXDataMethod.m
//  XikeTest
//
//  Created by lanou3g on 15/12/1.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "JXDataMethod.h"
#import "DestinationModel.h"
#import "RecommendModel.h"
#import "DiscoverModel.h"
@implementation JXDataMethod

#pragma mark ---- 解析DestinationModel
+ (void)requestDataClassName:(NSString *)className whereKey:(NSString *)whereKey equalTo:(NSString *)equalTo block:(void(^)(NSArray *array))RequestBlock{
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    AVQuery *query = [AVQuery queryWithClassName:className];
    [query whereKey:whereKey equalTo:equalTo];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (id ob in objects) {
                NSMutableDictionary *dic = [ob objectForKey:@"localData"];
                DestinationModel *model = [[DestinationModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                NSMutableArray *array = [dic objectForKey:@"placeIds"];
                model.placeIdsArray = [NSArray arrayWithArray:array];
                [modelArray addObject:model];
            }
            if (RequestBlock) {
                //之后换掉回调内容
                RequestBlock(modelArray);
            }
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark ---- 解析DiscoverModel
+ (void)requestDataClassName:(NSString *)className block:(void(^)(NSArray *array))RequestBlock{
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    AVQuery *query = [AVQuery queryWithClassName:className];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (id ob in objects) {
                NSMutableDictionary *dic = [ob objectForKey:@"localData"];
                DiscoverModel *model = [[DiscoverModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                
                NSMutableArray *array = [dic objectForKey:@"imageUrls"];
                model.imageUrls = [NSArray arrayWithArray:array];
                
                AVGeoPoint *p = [dic objectForKey:@"location"];
                model.location = p;
                
                [modelArray addObject:model];
            }
            if (RequestBlock) {
                //之后换掉回调内容
                RequestBlock(modelArray);
            }
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark ---- 解析DetialButton数据
+ (void)requestDataCity_id:(NSString *)city_id type:(NSString *)type sub_type:(NSString *)sub_type area:(NSString *)area sort:(NSString *)sort block:(void(^)(NSArray *array))RequestBlock{

    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    
    // 配置用户名 密码
    NSString * str = [NSString stringWithFormat:@"%@:%@",@"client",@"c31b32364ce19ca8fcd150a417ecce58"];
    // 进行加密  [str base64EncodedString]使用开源Base64.h分类文件加密
    NSString * str2 = [NSString stringWithFormat:@"Basic %@",[Base64 base64StringFromText:str]];
    
    if (sub_type == nil) {
        NSDictionary *dic1 = @{@"query":
                                  @{@"filtered":
                                        @{@"filter":
                                              @{@"and":
                                                    @[
                                                        @{@"term":
                                                              @{@"city_id":city_id}},
                                                        @{@"term":
                                                              @{@"type":type}},
                                                        @{@"range":
                                                              @{@"score":
                                                                    @{@"gte":@0}}},
                                                        @{@"term":
                                                              @{@"region":area}}
                                                        ]
                                                }
                                          }
                                    },
                              @"sort":
                                  @[
                                      @{sort:
                                            @{@"order":@"desc"}}],
                              @"size":@10,
                              @"from":@0};
        //1.管理器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //2.设定类型. (这里要设置request-response的类型)
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; //这个决定了下面responseObject返回的类型
        [manager.requestSerializer setValue:str2 forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // text/plain
        [manager POST:ButtonDetailAPI parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *data = [responseObject objectForKey:@"hits"];
            NSArray *array = [data objectForKey:@"hits"];
            for (NSDictionary *dic in array) {
                NSDictionary *dataDic = [dic objectForKey:@"_source"];
                RecommendModel *model = [[RecommendModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [modelArray addObject:model];
            }
            if (RequestBlock) {
                //之后换掉回调内容
                RequestBlock(modelArray);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"1.error = %@",error);
        }];
    } else if (area == nil) {
        NSDictionary *dic2 = @{@"query":
                                   @{@"filtered":
                                         @{@"filter":
                                               @{@"and":
                                                     @[
                                                         @{@"term":
                                                               @{@"city_id":city_id}},
                                                         @{@"term":
                                                               @{@"type":type}},
                                                         @{@"range":
                                                               @{@"score":
                                                                     @{@"gte":@0}}},
                                                         @{@"term":
                                                               @{@"sub_type":sub_type}}
                                                         ]
                                                 }
                                           }
                                     },
                               @"sort":
                                   @[
                                       @{sort:
                                             @{@"order":@"desc"}}],
                               @"size":@10,
                               @"from":@0};
        
        //1.管理器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //2.设定类型. (这里要设置request-response的类型)
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; //这个决定了下面responseObject返回的类型
        [manager.requestSerializer setValue:str2 forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // text/plain
        [manager POST:ButtonDetailAPI parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *data = [responseObject objectForKey:@"hits"];
            NSArray *array = [data objectForKey:@"hits"];
            for (NSDictionary *dic in array) {
                NSDictionary *dataDic = [dic objectForKey:@"_source"];
                RecommendModel *model = [[RecommendModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [modelArray addObject:model];
            }
            if (RequestBlock) {
                //之后换掉回调内容
                RequestBlock(modelArray);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"2.error = %@",error);
        }];
    } else {
        NSLog(@"sort = %@",sort);
        NSDictionary *dic3 = @{@"query":
                                   @{@"filtered":
                                         @{@"filter":
                                               @{@"and":
                                                     @[
                                                         @{@"term":
                                                               @{@"city_id":city_id}},
                                                         @{@"term":
                                                               @{@"type":type}},
                                                         @{@"range":
                                                               @{@"score":
                                                                     @{@"gte":@0}}},
                                                         @{@"term":
                                                               @{@"sub_type":sub_type}},
                                                         @{@"term":
                                                               @{@"region":area}}
                                                         ]
                                                 }
                                           }
                                     },
                               @"sort":
                                   @[
                                       @{sort:
                                             @{@"order":@"desc"}}],
                               @"size":@10,
                               @"from":@0};
        
        //1.管理器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //2.设定类型. (这里要设置request-response的类型)
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; //这个决定了下面responseObject返回的类型
        [manager.requestSerializer setValue:str2 forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // text/plain
        [manager POST:ButtonDetailAPI parameters:dic3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *data = [responseObject objectForKey:@"hits"];
            NSArray *array = [data objectForKey:@"hits"];
            for (NSDictionary *dic in array) {
                NSDictionary *dataDic = [dic objectForKey:@"_source"];
                RecommendModel *model = [[RecommendModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [modelArray addObject:model];
            }
            if (RequestBlock) {
                //之后换掉回调内容
                RequestBlock(modelArray);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"3.error = %@",error);
        }];
    }
}

#pragma mark ---- 解析DetialButton数据2
+ (void)requestData:(NSURL *)url block:(void(^)(NSArray *array))RequestBlock{
    
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    
    // 配置用户名 密码
    NSString * str = [NSString stringWithFormat:@"%@:%@",@"client",@"c31b32364ce19ca8fcd150a417ecce58"];
    // 进行加密  [str base64EncodedString]使用开源Base64.h分类文件加密
    NSString * str2 = [NSString stringWithFormat:@"Basic %@",[Base64 base64StringFromText:str]];
    
    //1.管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.设定类型. (这里要设置request-response的类型)
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // responseObject返回的类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:str2 forHTTPHeaderField:@"Authorization"];
    
    // text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];     [manager POST:ButtonDetailAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = [responseObject objectForKey:@"hits"];
        NSArray *array = [data objectForKey:@"hits"];
        for (NSDictionary *dic in array) {
            NSDictionary *dataDic = [dic objectForKey:@"_source"];
            RecommendModel *model = [[RecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [modelArray addObject:model];
        }
        if (RequestBlock) {
            //之后换掉回调内容
            RequestBlock(modelArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"4.error = %@",error);
    }];
}

#pragma mark ---- 解析RecommendModel
+ (void)requestPlaceIdsArray:(NSArray *)placeIdsArray block:(void(^)(NSArray *array))RequestBlock{
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSString *placeId in placeIdsArray) {
        NSString *API = [NSString stringWithFormat:@"https://com-cjker-trip-api-dev.shushuo.com/endpoint/com.cjker.trip.dev/place/%@/",placeId];
        NSURL *url = [NSURL URLWithString:API];
        //自定义的request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"GET";
        //配置用户名 密码
        NSString * str = [NSString stringWithFormat:@"%@:%@",@"client",@"dev"];
        // 进行加密  [str base64EncodedString]使用开源Base64.h分类文件加密
        NSString * str2 = [NSString stringWithFormat:@"Basic %@",[Base64 base64StringFromText:str]];
        [request setValue:str2 forHTTPHeaderField:@"Authorization"];

        AFHTTPRequestOperation *op=[[AFHTTPRequestOperation alloc]initWithRequest:request];
        //设置返回数据为json数据
        op.responseSerializer= [AFJSONResponseSerializer serializer];
        //发送网络请求
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [responseObject objectForKey:@"_source"];
            RecommendModel *model = [[RecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
            if (RequestBlock) {
                RequestBlock(modelArray);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        //请求完毕回到主线程
        [[NSOperationQueue mainQueue] addOperation:op];
        
    }
}

@end
