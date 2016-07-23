//
//  UIView+GKExtension.h
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GKExtension)
/// 边线颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/// 边线宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/// 圆角半径
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/// 从XIB加载控件
+ (instancetype)gk_loadFromXib;
/**
 *  局部圆角半径
 *
 *  @param cornerRadius 圆角半径大小
 *  @param corner       圆角半径位置
 */
- (void)gk_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)corner;

/// 获取一个view的控制器
- (UIViewController*)gk_viewController;
/// 添加顶部分割线
- (UIView*)addTopLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha;
/// 添加底部分割线
- (UIView*)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha;
@end
