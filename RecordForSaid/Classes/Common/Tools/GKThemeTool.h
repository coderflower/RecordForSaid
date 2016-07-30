//
//  GKThemeTool.h
//  换肤
//
//  Created by 花菜ChrisCai on 2016/6/30.
//  Copyright © 2016年 Chris.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
UIKIT_EXTERN  NSString * const GKThemeKey;

UIKIT_EXTERN NSString * const kNightModelKey;
UIKIT_EXTERN NSString * const kPushNotelKey;
/** 主题类型 */
typedef NS_ENUM(NSUInteger, GKThemeType) {
    /** 黑夜 */
    GKThemeTypeNight,
    /** 白天 */
    GKThemeTypeDaytime,
};

/** 图片类型 */
typedef NS_ENUM(NSUInteger, GKThemeImageType) {
    GKThemeImageTypeBackImage,
    GKThemeImageTypeBtnImage,
};

/** 图片类型 */
typedef NS_ENUM(NSUInteger, GKThemeColor) {
    GKThemeBackgroundColor,
    GKThemeTextColor
};


@interface GKThemeTool : NSObject
/**
 * 保存主题
 */
+ (void)setThemeWithType:(GKThemeType)themeType;

/**
 * 获取图片类型
 */
+ (UIImage *)getThemeImageWithType:(GKThemeImageType)imageType;
/**
 * 获取文本颜色
 */
+ (UIColor *)getTextColor;
/**
 *  获取背景颜色
 */
+ (UIColor *)getBackgroundColor;
+ (void)setTheme;
@end
