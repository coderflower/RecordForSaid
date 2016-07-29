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
/** 夜间主题 */
static NSString * const kThemeKeyNight = @"night";
/** 白天主题 */
static NSString * const kThemeKeyDaytime = @"daytime";

NSString * const kNightModelKey = @"kNightModelKey";
NSString * const kPushNotelKey = @"kPushNotelKey";
@implementation GKThemeTool

/**
 * 保存主题
 */
+ (void)setThemeWithType:(GKThemeType)themeType {
    switch (themeType) {
        case GKThemeTypeNight:
            [[NSUserDefaults standardUserDefaults] setObject:kThemeKeyNight forKey:GKThemeKey];
            break;
        case GKThemeTypeDaytime:
            [[NSUserDefaults standardUserDefaults] setObject:kThemeKeyDaytime forKey:GKThemeKey];
            break;
        default:
            break;
    }
}

/**
 * 获取图片类型
 */
+ (UIImage *)getThemeImageWithType:(GKThemeImageType)imageType {
    NSString *theme = [[NSUserDefaults standardUserDefaults] objectForKey:GKThemeKey];
    UIImage *image;
    switch (imageType) {
        case GKThemeImageTypeBackImage:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"theme.bundle/%@/back.png",theme]];
            break;
        case GKThemeImageTypeBtnImage:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"theme.bundle/%@/icon.png",theme]];
            break;
        default:
            break;
    }
    return image;
}
/**
 * 获取背景颜色
 */
+ (UIColor *)getBackgroundColor {
    NSString *colorPath = [[NSBundle mainBundle] pathForResource:@"ColorConfig.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:colorPath];
    NSString *colorStr;
    // 根据主题, 获取颜色
    NSString *theme = [[NSUserDefaults standardUserDefaults] objectForKey:GKThemeKey];
    if ([theme isEqualToString:kThemeKeyDaytime]) {
        colorStr = dict[@"daytimeBackgroundColor"];
    } else if ([theme isEqualToString:kThemeKeyNight]) {
        colorStr = dict[@"nightBackgroundColor"];

    }
    NSArray *colors = [colorStr componentsSeparatedByString:@","];
    
    UIColor *color = [UIColor colorWithRed:[colors[0] doubleValue] / 255.0 green:[colors[1] doubleValue] / 255.0 blue:[colors[2] doubleValue] / 255.0 alpha:1];
    
    return color;
}

/**
 * 获取文本颜色
 */
+ (UIColor *)getTextColor {
    
    NSString *colorPath = [[NSBundle mainBundle] pathForResource:@"ColorConfig.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:colorPath];
    NSString *colorStr;
    // 根据主题, 获取颜色
    NSString *theme = [[NSUserDefaults standardUserDefaults] objectForKey:GKThemeKey];
    if ([theme isEqualToString:kThemeKeyDaytime]) {
        colorStr = dict[@"daytimeTextColor"];
    } else if ([theme isEqualToString:kThemeKeyNight]) {
        colorStr = dict[@"nightTextColor"];
        
    }
    
    NSArray *colors = [colorStr componentsSeparatedByString:@","];
    
    UIColor *color = [UIColor colorWithRed:[colors[0] doubleValue] / 255.0 green:[colors[1] doubleValue] / 255.0 blue:[colors[2] doubleValue] / 255.0 alpha:1];
    
    return color;
}


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
        [tabBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]];
        attri[NSForegroundColorAttributeName] = [UIColor  blackColor];
        [navBar setTintColor:GKRGBColor(85, 85, 85)];
    }
    [navBar setTitleTextAttributes:attri];
}

@end
