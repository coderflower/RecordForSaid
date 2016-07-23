//
//  UIColor+GKExtension.m
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIColor+GKExtension.h"

@implementation UIColor (GKExtension)

+ (UIColor *)gk_colorFromHex:(NSInteger)hex {
    return [self gk_colorFromHex:hex alpha:1.0f];
}

+ (UIColor *)gk_colorFromHex:(NSInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0
                           alpha:alpha];
}
@end
