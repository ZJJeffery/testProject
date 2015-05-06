//
//  UIImage+Extention.m
//
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)
#pragma mark - 拉伸图片
+ (instancetype)resizeImage:(NSString *)imgName
{
    // 根据图片名获取图片
    UIImage *img = [UIImage imageNamed:imgName];
    // 判断是否存在该图片
    if (img == nil) {
        NSLog(@"%s : There is no such image called: “%@”,Please check the image name", __func__, img);
        return nil;
    }
    // 返回可拉伸图片
    return [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
}
#pragma mark - 给图片打水印
+(instancetype)watermarkRingImageWithImageName:(NSString *)imageName andLogoName:(NSString *)logoName
{
    // 获取无水印图片
    UIImage *originalImage = [UIImage imageNamed:imageName];
    // 根据给定的名称判断是否有该图片
    if (originalImage == nil) {
        // 没有就提示检查是否是名称输入错误
        NSLog(@"%s:There is no such image called: “%@” in waterMarkImageWithImageName: method, Please check the image name", __func__, imageName);
        return nil;
    }
    // 获取水印标志
    UIImage *logoImage = [UIImage imageNamed:logoName];
    // 根据给定的名称判断是否有该图片
    if (logoImage == nil) {
        // 没有就提示检查是否是名称输入错误
        NSLog(@"%s:There is no such image called: “%@” in waterMarkImageWithImageName: method, Please check the logo name", __func__,logoName);
        return nil;
    }
    
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    // 添加无水印图片到上下文
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    
    // 计算水印位置
    CGFloat w = logoImage.size.width * 0.5;
    CGFloat h = logoImage.size.height * 0.5;
    CGFloat x = originalImage.size.width - w;
    CGFloat y = originalImage.size.height - h;
    // 添加水印
    [logoImage drawInRect:CGRectMake(x, y, w, h)];
    
    // 从上下文中获取新图片
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回结果图片
    return waterImage;

}
#pragma mark - 裁减图片成为一个圆图片
+(instancetype)circleImageWithImageName:(NSString *)imageName
{
    // 读取需要裁减的图片
    UIImage *originalImage = [UIImage imageNamed:imageName];
    // 根据给定的名称判断是否有该图片
    if (originalImage == nil) {
        // 没有就提示检查是否是名称输入错误
        NSLog(@"%s:There is no such image called: “%@” in circleImageWithImageName: method, Please check the image name", __func__, imageName);
        return nil;
    }
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置圆的属性
    CGFloat centerX = originalImage.size.width * 0.5;
    CGFloat centerY = originalImage.size.height * 0.5;
    // 根据长宽中最短的一个的一半作为半径
    CGFloat radius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    // 添加圆
    CGContextAddArc(ctx, centerX, centerY, radius, 0, M_PI * 2, 1);
    // 根据圆裁减现在的上下文
    CGContextClip(ctx);
    
    // 在已裁减的上下文基础上添加图片
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    
    // 获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回结果图片
    return newImage;
}
#pragma mark - 裁减图片额外加圆环
+(instancetype)circleImageWithImageName:(NSString *)imageName withAdditionalCircle:(CGFloat)circleBorderLength withBorderColor:(UIColor *)borderColor
{
    // 读取需要裁减的图片
    UIImage *originalImage = [UIImage imageNamed:imageName];
    // 根据给定的名称判断是否有该图片
    if (originalImage == nil) {
        // 没有就提示检查是否是名称输入错误
        NSLog(@"%s: There is no such image called: “%@” in circleImageWithImageName:withAdditionalCircle: method, Please check the image name", __func__, imageName);
        return nil;
    }
    // 图片大小
    CGFloat imageWidth = originalImage.size.width;
    CGFloat imageHeight = originalImage.size.height;
    // 计算上下文大小(额外增加额外的长度)
    CGFloat contextWidth = imageWidth + 2 * circleBorderLength;
    CGFloat contextHeight = imageHeight + 2 * circleBorderLength;
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextWidth, contextHeight), NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加大圆用于圆环
    // 设置圆的属性
    CGFloat centerBigX = contextWidth * 0.5;
    CGFloat centerBigY = contextHeight * 0.5;
    // 根据长宽中最短的一个的一半作为半径
    CGFloat radiusBig = MIN(contextWidth, contextHeight) * 0.5;
    // 添加圆
    CGContextAddArc(ctx, centerBigX, centerBigY, radiusBig, 0, M_PI * 2, 1);
    // 设置圆的颜色
    [borderColor setFill];
    // 渲染
    CGContextFillPath(ctx);
    
    // 设置小圆用于裁减
    // 设置圆的属性
    CGFloat centerSmallX = centerBigX;
    CGFloat centerSmallY = centerBigY;
    // 根据长宽中最短的一个的一半作为半径
    CGFloat radiusSmall = MIN(imageWidth, imageHeight) * 0.5;
    // 添加圆
    CGContextAddArc(ctx, centerSmallX, centerSmallY, radiusSmall, 0, M_PI * 2, 1);
    // 裁减小圆
    CGContextClip(ctx);
    
    // 添加图片
    [originalImage drawInRect:CGRectMake(circleBorderLength, circleBorderLength, imageWidth, imageHeight)];
    // 从上下文提取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回新图片
    return newImage;
}
#pragma mark - 截图
+ (instancetype)captureShotWithView:(UIView *)view
{
    // 判断给的view是否存在
    if (view == nil) {
        NSLog(@"%s: There is no View in captureShotWithView, Please check the view", __func__);
        return nil;
    }
    // 开启图片上下文(根据需要裁减的view给出大小)
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 根据View的图层提取截图(将视图的图层粉刷到上下文)
    [view.layer renderInContext:ctx];
    // 从上下文获取截图图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回截图
    return screenShot;
}

#pragma mark - 截图
+ (instancetype)captureShotWithView:(UIView *)view inRect:(CGRect)rect
{
    // 判断给的view是否存在
    if (view == nil) {
        NSLog(@"%s: There is no View in captureShotWithView, Please check the view", __func__);
        return nil;
    }
    // 开启图片上下文(根据需要裁减的view给出大小)
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置裁减区域
    CGContextAddRect(ctx, rect);
    // 裁减区域
    CGContextClip(ctx);
    // 根据View的图层提取截图(将视图的图层粉刷到上下文)
    [view.layer renderInContext:ctx];
    // 从上下文获取截图图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回截图
    return screenShot;
}


@end
