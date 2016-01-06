//
//  RootTabBarController.m
//  XikelvxingTest
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RootTabBarController.h"
#import "DestinationViewController.h"
#import "MyViewController.h"
#import "WMPageController.h"
#import "HotViewController.h"
#import "NewViewController.h"
#import "MyDetailViewController.h"

@interface RootTabBarController ()


@end

@implementation RootTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加视图控制器
    [self setControllers];

}

//添加controller
- (void)setControllers
{
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
    // 目的地
    DestinationViewController * destinationVC = [[DestinationViewController alloc] init];
    UINavigationController * destinationNC = [[UINavigationController alloc] initWithRootViewController:destinationVC];
    destinationNC.tabBarItem.title = @"目的地";
    destinationNC.tabBarItem.image = [UIImage imageNamed:@"icon_place_light_sketch.png"];
    
    // 发现
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    Class vcClass1 = [HotViewController class];
    NSString *title1 = @"热门";
    Class vcClass2 = [NewViewController class];
    NSString *title2 = @"最新";
    [viewControllers addObject:vcClass1];
    [titles addObject:title1];
    [viewControllers addObject:vcClass2];
    [titles addObject:title2];
    
    WMPageController *discoverVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];;
    
    discoverVC.pageAnimatable = YES;
    discoverVC.menuItemWidth = 85;
    discoverVC.postNotification = YES;
    discoverVC.bounces = YES;
    discoverVC.menuViewStyle = WMMenuViewStyleLine;
    discoverVC.titleSizeSelected = 15;
    
    // 我的
    UINavigationController *discoverNC = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    discoverNC.tabBarItem.image = [UIImage imageNamed:@"icon_camera_light_sketch"];
    discoverNC.tabBarItem.title = @"发现";
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *myNC  = [[UINavigationController alloc] initWithRootViewController:myVC];
    myNC.tabBarItem.image = [UIImage imageNamed:@"icon_direction_sketch"];
    myNC.tabBarItem.title = @"我的";
    
    self.viewControllers = @[destinationNC,discoverNC,myNC];
    
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
