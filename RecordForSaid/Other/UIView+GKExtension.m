//
//  UIView+GKExtension.m
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIView+GKExtension.h"

@implementation UIView (GKExtension)
+ (instancetype)gk_loadFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)gk_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)corner
{
    CGSize radio = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (UIViewController*)gk_viewController {
    for (UIView* next = [self superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController * )nextResponder;
        }
    }
    return nil;
}

- (UIView*)addTopLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha
{
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.width,height)];
    topLine.backgroundColor = color;
    topLine.alpha = alpha;
    
    topLine.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self addSubview:topLine];
    
    NSLayoutConstraint *topContraint=[NSLayoutConstraint
                                      constraintWithItem:topLine
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                      attribute:NSLayoutAttributeTop
                                      multiplier:1.0f
                                      constant:0.0];
    NSLayoutConstraint *widthContraint=[NSLayoutConstraint
                                        constraintWithItem:topLine
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeWidth
                                        multiplier:1.0f
                                        constant:0.0];
    
    NSLayoutConstraint *heightContraint=[NSLayoutConstraint
                                         constraintWithItem:topLine
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                         constant:height];
    
    NSLayoutConstraint *leadingContraint=[NSLayoutConstraint
                                          constraintWithItem:topLine
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self
                                          attribute:NSLayoutAttributeLeading
                                          multiplier:1.0f
                                          constant:0.0];
    
    [topLine addConstraint:heightContraint];
    //给button的父节点添加约束
    [self addConstraints:@[topContraint,widthContraint,leadingContraint]];
    
    return topLine;
    
}

- (UIView*)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha
{
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.height- height,self.width,height)];
    bottomLine.backgroundColor = color;
    bottomLine.alpha = alpha;
    bottomLine.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:bottomLine];
    
    NSLayoutConstraint *bottomContraint=[NSLayoutConstraint
                                         constraintWithItem:bottomLine
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                         attribute:NSLayoutAttributeBottom
                                         multiplier:1.0f
                                         constant:0.0];
    NSLayoutConstraint *widthContraint=[NSLayoutConstraint
                                        constraintWithItem:bottomLine
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeWidth
                                        multiplier:1.0f
                                        constant:0.0];
    
    NSLayoutConstraint *heightContraint=[NSLayoutConstraint
                                         constraintWithItem:bottomLine
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                         constant:height];
    
    NSLayoutConstraint *leadingContraint=[NSLayoutConstraint
                                          constraintWithItem:bottomLine
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self
                                          attribute:NSLayoutAttributeLeading
                                          multiplier:1.0f
                                          constant:0.0];
    
    
    
    [bottomLine addConstraint:heightContraint];
    //给button的父节点添加约束
    [self addConstraints:@[bottomContraint,widthContraint,leadingContraint]];
    
    
    return bottomLine;
}


@end
