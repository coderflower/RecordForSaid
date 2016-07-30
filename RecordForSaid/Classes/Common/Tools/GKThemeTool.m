//
//  GKThemeTool.m
//  换肤
//
//  Created by 花菜ChrisCai on 2016/6/30.
//  Copyright © 2016年 Chris.Cai. All rights reserved.
//

#import "GKThemeTool.h"
/** 主题信息 */
NSString * const GKThemeKey = @"theme";
NSString * const kNightModelKey = @"kNightModelKey";
NSString * const kPushNotelKey = @"kPushNotelKey";
@implementation GKThemeTool

+ (void)setTheme {
    // 获取全局导航条
    UINavigationBar * navBar = [UINavigationBar appearance];
    UITabBar *tabBar = [UITabBar appearance];
    NSMutableDictionary * attri = [NSMutableDictionary dictionary];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kNightModelKey]) {
        // 夜间模式
        [navBar setBackgroundImage:[UIImage gk_imageWithColor:GKRGBColor(85, 85, 85)] forBarMetrics:UIBarMetricsDefault];
        [tabBar  setBackgroundImage:[UIImage gk_imageWithColor:GKRGBColor(85, 85, 85)]];
        attri[NSForegroundColorAttributeName] = [UIColor  whiteColor];
        [navBar setTintColor:[UIColor whiteColor]];
    }else {
        // 白天模式
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        [tabBar setBackgroundImage:[UIImage imageNamed:@"tabBarBg"]];
        attri[NSForegroundColorAttributeName] = [UIColor  blackColor];
        [navBar setTintColor:GKRGBColor(85, 85, 85)];
    }
    [navBar setTitleTextAttributes:attri];
}

@end
