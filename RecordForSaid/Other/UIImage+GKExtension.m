//
//  UIImage+GKExtension.m
//  爱鲜蜂
//
//  Created by 花菜ChrisCai on 2016/7/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIImage+GKExtension.h"
#import <objc/runtime.h>
static CGContextRef _newBitmapContext(CGSize size)
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    size_t imgWith = (size_t)(size.width + 0.5);
    size_t imgHeight = (size_t)(size.height + 0.5);
    size_t bytesPerRow = imgWith * 4;
    
    CGContextRef context = CGBitmapContextCreate(
                                                 NULL,
                                                 imgWith,
                                                 imgHeight,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpaceRef);
    return context;
}

@implementation UIImage (GKExtension)
#pragma mark -
#pragma mark - =============== 获取图片主色 ===============
+ (UIColor *)mostColorWithImage:(UIImage *)image {
    
# if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    // 第一步 ，先把图片缩小，加快计算速度，越小结果误差可能越大
    
    CGSize thumbSize = CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8/*8位*/,
                                                 thumbSize.width * 4,
                                                 colorSpace,
                                                 bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    // 第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData(context);
    
    if (data == NULL) {
        return NULL;
    }
    
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4 * (x * y);
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha = data[offset + 3];
            
            if (alpha != 255) {
                continue;
            }
            
            NSArray *clr = @[@(red),@(green),@(blue),@(alpha)];
            
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);
    
    // 第三步 找出出现次数最多的那个颜色
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;
    
    while ((curColor = [enumerator nextObject]) != nil) {
        NSUInteger temCount = [cls countForObject:curColor];
        
        if (temCount < MaxCount) {
            continue;
        }
        
        MaxCount = temCount;
        MaxColor = curColor;
    }
    //    NSLog(@"%d,,,%d,,,%d",[MaxColor[0] intValue],[MaxColor[1] intValue],[MaxColor[2] intValue]);
    
    return [UIColor colorWithRed:[MaxColor[0] intValue]/255.0f green:[MaxColor[1] intValue]/255.0f blue:[MaxColor[2] intValue]/255.0f alpha:1.0];
}
#pragma mark -
#pragma mark - 拉伸图片
+ (UIImage *)gk_resizingImage:(NSString *)imageName{
    // 根据图片名创建图片对象
    UIImage *image = [UIImage imageNamed:imageName];
    // 找到可拉伸的区域
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    // 获取可拉伸的图片(区域)
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5 - 1, imageW * 0.5 - 1) resizingMode:UIImageResizingModeStretch];
    
    return image;
}

#pragma mark -
#pragma mark - 禁用渲染
+ (instancetype)gk_imageOriginalWithImageName:(NSString *)imageName {
    // 获取图片
    UIImage *image = [UIImage imageNamed:imageName];
    // 告诉系统不要渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 返回新的图片
    return image;
}

#pragma mark -
#pragma mark - 带边框(可选)圆形图片裁剪
+ (UIImage *)gk_imageWithClipImageNamed:(NSString *)clipImageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    
    return [self gk_imageWithClipImage:[UIImage imageNamed:clipImageName] borderWidth:borderWidth borderColor:borderColor];
}

+ (UIImage *)gk_imageWithClipImage:(UIImage *)clipImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 设置圆环宽度
    CGFloat border = borderWidth;
    
    // 获取正方形
    CGSize size = clipImage.size.width >= clipImage.size.height ? CGSizeMake(clipImage.size.height, clipImage.size.height) : CGSizeMake(clipImage.size.width, clipImage.size.width);
    // 图片宽高
    CGFloat imageWH = size.width;
    
    // 设置外框尺寸
    CGFloat ovalWH = imageWH + 2 *border;
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    // 画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    // 填充
    [path fill];
    
    // 设置圆形裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    
    [clipPath addClip];
    
    // 绘制图片
    [clipImage drawAtPoint:CGPointMake(border, border)];
    
    // 从上下文获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -
#pragma mark - 控件截图
+ (UIImage *)gk_imageWithcaptureView:(UIView *)view {
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 将控件上的图层渲染上下文
    [view.layer renderInContext:ctx];
    
    // 生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -
#pragma mark - 颜色生成图片
+ (instancetype)gk_imageWithColor:(UIColor *)color
{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 获取当前位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGContextFillRect(ctx, rect);
    
    // 从上下文获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

#pragma mark -
#pragma mark - 根据CIImage生成指定大小的UIImage
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)gk_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
#pragma mark -
#pragma mark - 快速生成二维码
+ (UIImage *)gk_createQRCodeWithInputData:(NSData *)inputData size:(CGFloat)size
{
    return [UIImage gk_createQRCodeWithInputData:inputData centerImage:nil size:size];
}

#pragma mark -
#pragma mark - 快速生成中间有图片的二维码
+ (UIImage *)gk_createQRCodeWithInputData:(NSData *)inputData  centerImage:(UIImage *)centerImage size:(CGFloat)size
{
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.设置相关属性
    [filter setDefaults];
    // 3.设置输入源
    [filter setValue:inputData forKeyPath:@"inputMessage"];
    // 4.获取输出结果(直接使用该图片显示到view上会比较模糊)
    CIImage *outputImage = [filter outputImage];
    // 5.图片处理
    CGAffineTransform transform = CGAffineTransformMakeScale(20, 20);
    outputImage = [outputImage imageByApplyingTransform:transform];
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    //    UIImage *image =  [UIImage gk_createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
    if (centerImage) {
        
        UIImageView *imageView =[self imageViewWithImage:image centerImage:centerImage];
        
        return [UIImage gk_imageWithcaptureView:imageView]; // 控件截图
    }else {
        return image;
    }
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image centerImage:(UIImage *)centerImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    UIImageView *centerImageView = [[UIImageView alloc]init];
    
    CGFloat centerImageHW = 90; // 设置默认宽高
    // 居中显示
    CGFloat centerImageX = (imageView.bounds.size.width - centerImageHW) * 0.5;
    CGFloat centerImageY = (imageView.bounds.size.height - centerImageHW) * 0.5;;
    // 设置frame
    centerImageView.frame = CGRectMake(centerImageX, centerImageY, centerImageHW, centerImageHW);
    centerImageView.image = centerImage;
    centerImageView.layer.borderWidth = 5; // 默认边框宽度
    centerImageView.layer.cornerRadius = 10;// 默认圆角半径
    centerImageView.layer.borderColor = [UIColor whiteColor].CGColor;//默认边框颜色
    centerImageView.layer.masksToBounds = YES;
    [imageView addSubview:centerImageView];
    return imageView;
}
/**
 *  给图片增加一个像素的透明边框
 */
- (UIImage *)gk_antiAlias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    UIImage *img = nil;
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return antiImage;
}

- (instancetype)gk_circleImage
{
    return [UIImage gk_imageWithClipImage:self borderWidth:0 borderColor:kNilOptions];
}

+ (instancetype)gk_circleImage:(NSString *)name
{
    return [[self imageNamed:name] gk_circleImage];
}

#pragma mark -
#pragma mark - =============== 生成一张单色图片 ===============
+ (UIImage*) imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGContextRef context = _newBitmapContext(size);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage* img = [UIImage imageWithCGImage:imgRef];
    
    CGContextRelease(context);
    CGImageRelease(imgRef);
    
    return img;
}


+ (void)load
{
    Method m1 = class_getClassMethod(self, @selector(imageNamed:));
    
    Method m2 = class_getClassMethod(self, @selector(imageWithName:));
    
    method_exchangeImplementations(m1, m2);
}

+ (instancetype)imageWithName:(NSString *)name
{
    if (name.length) {
        UIImage *image = [UIImage imageWithName:name];
        return image;
    }else {
        NSLog(@"图片名为空");
        return nil;
    }
    
}



@end




