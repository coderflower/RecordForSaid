//
//  UIBarButtonItem+GKExtension.h
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/27.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GKExtension)
/**
 *  创建UIBarButtonItem,高亮
 *
 *  @param image    图片
 *  @param highImage 高亮图片
 *  @param target   监听者
 *  @param action   监听者调用的方法
 *
 */
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

/**
 *  创建UIBarButtonItem,选中
 *
 *  @param image    图片
 *  @param highImage 高亮图片
 *  @param target   监听者
 *  @param action   监听者调用的方法
 *
 */
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;

/**
 *  创建返回按钮
 *
 *  @param image     返回按钮图片
 *  @param highImage 高亮图片
 *  @param target    监听者
 *  @param action    监听者调用的方法
 *  @param title     标题
 *
 */
+ (UIBarButtonItem *)createBackItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  只带标题的按钮
 *
 *  @param title  标题
 *  @param target 监听者
 *  @param action 监听者调用的方法
 *
 *  @return
 */
+ (UIBarButtonItem *)createItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
