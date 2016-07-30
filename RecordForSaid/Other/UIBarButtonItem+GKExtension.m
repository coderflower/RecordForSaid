//
//  UIBarButtonItem+GKExtension.m
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/27.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIBarButtonItem+GKExtension.h"

@implementation UIBarButtonItem (GKExtension)
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    [buttonView addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}

+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setImage:image forState:UIControlStateNormal];
    [but setImage:selectedImage forState:UIControlStateSelected];
    [but sizeToFit];
    [but addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *butV = [[UIView alloc] initWithFrame:but.bounds];
    [butV addSubview:but];
    return [[UIBarButtonItem alloc] initWithCustomView:butV];
}
//设置返回按钮
+ (UIBarButtonItem *)createBackItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    //设置内容内边框
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)createItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    [buttonView addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}
@end
