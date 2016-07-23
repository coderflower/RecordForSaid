//
//  UIColor+GKExtension.h
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GKRGBAColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define GKRGBColor(r, g, b) GKRGBAColor(r, g, b,1)
#define GKGlobalColor GKRGBColor(230,230,230)
#define GKRandomColor GKRGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))
#define GKClearColor [UIColor clearColor]
@interface UIColor (GKExtension)
/**
 *  十六进制转颜色
 *
 *  @param hex 进制
 *
 *  @return RGB颜色
 */
+ (UIColor *)gk_colorFromHex:(NSInteger)hex;
/**
 *  十六进制转颜色
 *
 *  @param hex   十六进制数字
 *  @param alpha 透明度
 *
 *  @return RGB颜色
 */
+ (UIColor *)gk_colorFromHex:(NSInteger)hex alpha:(CGFloat)alpha;
@end
