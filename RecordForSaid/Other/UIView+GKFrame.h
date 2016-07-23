//
//  UIView+GKFrame.h
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GKFrame)
/** x坐标 */
@property (nonatomic, assign) CGFloat x;

/** y坐标 */
@property (nonatomic, assign) CGFloat y;

/** 中心点x */
@property (nonatomic, assign) CGFloat centerX;

/**  中心点y */
@property (nonatomic, assign) CGFloat centerY;

/** 宽度按 */
@property (nonatomic, assign) CGFloat width;

/** 高度 */
@property (nonatomic, assign) CGFloat height;

/** 宽高尺寸 */
@property (nonatomic, assign) CGSize size;

/** x,y 坐标 */
@property (nonatomic, assign) CGPoint origin;

/** 获取最大值X */
- (CGFloat)maxX;
/** 获取最大值Y */
- (CGFloat)maxY;
@end

@interface UIScrollView (Extension)
// Content Offset
@property (nonatomic) CGFloat contentOffsetX;
@property (nonatomic) CGFloat contentOffsetY;

// Content Size
@property (nonatomic) CGFloat contentSizeWidth;
@property (nonatomic) CGFloat contentSizeHeight;

// Content Inset
@property (nonatomic) CGFloat contentInsetTop;
@property (nonatomic) CGFloat contentInsetLeft;
@property (nonatomic) CGFloat contentInsetBottom;
@property (nonatomic) CGFloat contentInsetRight;
@end