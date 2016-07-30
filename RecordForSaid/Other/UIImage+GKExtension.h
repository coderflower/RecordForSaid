//
//  UIImage+GKExtension.h
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GKExtension)

/**
 *  获取图片主颜色
 *
 *  @param image 图片
 *
 *  @return 颜色
 */
+ (UIColor *)mostColorWithImage:(UIImage *)image;
/**
 *  生成一副单色的图片
 *
 *  @param color 颜色
 *  @param size  生成图片的大小
 *
 *  @return 图片
 */
+ (UIImage*) imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  生成可拉伸的图片
 *
 *  @param imageName 原始图片名
 *
 *  @return 可拉伸的图片
 */
+ (UIImage *)gk_resizingImage:(NSString *)imageName;
/**
 *  生成一张禁用系统渲染的图片
 *
 *  @param imageName 原始图片名
 *
 *  @return 禁用系统渲染的图片
 */
+ (instancetype)gk_imageOriginalWithImageName:(NSString *)imageName;
/**
 *  带边框(可选)圆形图片裁剪
 *
 *  @param clipImageName 待裁剪的图片名
 *  @param borderWidth   圆环宽度
 *  @param borderColor   圆环颜色
 *
 *  @return 裁剪好的图片
 */
+ (UIImage *)gk_imageWithClipImageNamed:(NSString *)clipImageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  快速截取控件显示的内容(控件截图)
 *
 *  @param view 需要截取的控件
 *
 *
 */
+ (UIImage *)gk_imageWithcaptureView:(UIView *)view;
/**
 *  根据颜色生成一张尺寸为1*1的相同颜色图片
 *
 *  @param color 需要转换的颜色
 *
 *  @return 生成一张尺寸为1*1的相同颜色图片
 */
+ (instancetype)gk_imageWithColor:(UIColor *)color;
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽高
 */
+ (UIImage *)gk_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
/**
 *  快速生成二维码
 *
 *  @param inputData 输入源(需要转换成二维码的数据)
 *  @param size      生成二维码的宽高
 *
 */
+ (UIImage *)gk_createQRCodeWithInputData:(NSData *)inputData size:(CGFloat)size;
/**
 *  快速生成中间有图片的二维码
 *
 *  @param inputData   输入源(需要转换成二维码的数据)
 *  @param centerImage 显示在中间的图片(默认尺寸90 * 90) 边框宽度:5 圆角半径:10 边框颜色:白色
 *  @param size        生成二维码的宽高
 *
 */
+ (UIImage *)gk_createQRCodeWithInputData:(NSData *)inputData  centerImage:(UIImage *)centerImage size:(CGFloat)size;
/**
 *  带边框(可选)圆形图片裁剪
 *
 *  @param clipImageName 待裁剪的图片
 *  @param borderWidth   圆环宽度
 *  @param borderColor   圆环颜色
 *
 *  @return 裁剪好的图片
 */
+ (UIImage *)gk_imageWithClipImage:(UIImage *)clipImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  给图片增加一个像素的透明边框
 */
- (UIImage *)gk_antiAlias;

/**
 *  获取圆形图片
 */
- (instancetype)gk_circleImage;
/**
 *  获取圆形图片
 *
 *  @param name 图片名
 *
 */
+ (instancetype)gk_circleImage:(NSString *)name;
@end
