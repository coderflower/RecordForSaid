//
//  GKNavigationController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKNavigationController.h"

@interface GKNavigationController ()

@end

@implementation GKNavigationController

+ (void)initialize {
    // 设置当前类的全局导航条背景图片
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // 设置当类的全局导航条标题字体
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:attri];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *normalAttri = [NSMutableDictionary dictionary];
    normalAttri[NSForegroundColorAttributeName] = [UIColor blackColor];
    normalAttri[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledAttri = [NSMutableDictionary dictionary];
    disabledAttri[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disabledAttri forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
