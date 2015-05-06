//
//  UIImage+Extention.h
//  
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
/**
 *  拉伸图片不变形
 *
 *  @param imgName 原始图片名称
 *
 *  @return 新的可拉伸图片
 */
+ (instancetype)resizeImage:(NSString *)imgName;
/**
 *  给图片合成为新的有水印的图片
 *
 *  @param imageName 需要添加水印的图片名称
 *  @param logoName  水印图片名称
 *
 *  @return 有水印的新图片
 */
+ (instancetype)watermarkRingImageWithImageName:(NSString *)imageName andLogoName:(NSString *)logoName;
/**
 *  根据给定的图片的大小给出最合适的圆形裁减图片
 *
 *  @param imageName 需要裁减的图片的名称
 *
 *  @return 新的裁减完的图片
 */
+ (instancetype)circleImageWithImageName:(NSString *)imageName;
/**
 *  裁减圆图像并且增加一个圆环
 *
 *  @param imageName          需裁减的图片名称
 *  @param circleBorderLength 外圆环的长度
 *  @param borderColor        外圆环颜色
 *
 *  @return 裁减完的图片
 */
+(instancetype)circleImageWithImageName:(NSString *)imageName withAdditionalCircle:(CGFloat)circleBorderLength withBorderColor:(UIColor *)borderColor;
/**
 *  截取给定的View的内容（截图）
 *
 *  @param view 需要截图的View
 *
 *  @return 截好的图片
 */
+(instancetype)captureShotWithView:(UIView *)view;
+ (instancetype)captureShotWithView:(UIView *)view inRect:(CGRect)rect;
@end
