//
//  GKTabBarController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKTabBarController.h"
#import "GKTabBar.h"
#import "GKRecordViewController.h"
#import "GKNavigationController.h"
@interface GKTabBarController ()

@end

@implementation GKTabBarController

+ (void)initialize {
    [GKThemeTool setTheme];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews {
    
    GKTabBar *tabBar = [[GKTabBar alloc]init];
    // 系统的tabBar属性是readonly,只能利用KVC修改
    [self setValue:tabBar forKey:@"tabBar"];
    GKWeakSelf(self)
    GKNavigationController * nav = [[GKNavigationController alloc]initWithRootViewController:[[GKRecordViewController alloc] init]];
    tabBar.publishClick = ^{
        [weakself presentViewController:[[GKRecordViewController alloc] init] animated:YES completion:nil];
    };
}


@end
