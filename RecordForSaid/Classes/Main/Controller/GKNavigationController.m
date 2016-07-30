//
//  GKNavigationController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKNavigationController.h"

@interface GKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation GKNavigationController

+ (void)initialize {
    // 设置当前类的全局导航条背景图片
    [GKThemeTool setTheme];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    
    // 清空滑动返回手势代理, 恢复滑动功能
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 判断如果当前控制器处于子控制器的时候, 才触发手势
    return self.childViewControllers.count > 1;
}

@end
