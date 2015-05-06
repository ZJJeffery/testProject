//
//  UIView+Extension.m
//
//
//  Created by Jiajun Zheng on 15/4/8.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/**
 *  直接改变控件frame中的x属性
 *
 *  @param x 需要改变的x数值
 */
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
/**
 *  直接返回控件frame中的x属性
 */
-(CGFloat)x
{
    return self.frame.origin.x;
}
/**
 *  直接改变控件frame中的y属性
 *
 *  @param y 需要改变的y数值
 */
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
/**
 *  直接返回控件frame中的y属性
 */
-(CGFloat)y
{
    return self.frame.origin.y;
}
/**
 *  直接改变控件frame中的width属性
 *
 *  @param w 需要改变的width数值
 */
-(void)setW:(CGFloat)w
{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}
/**
 *  直接返回控件frame中的width属性
 */
-(CGFloat)w
{
    return self.frame.size.width;
}
/**
 *  直接改变控件frame中的height属性
 *
 *  @param h 需要改变的height数值
 */
-(void)setH:(CGFloat)h
{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}
/**
 *  直接返回控件frame中的height属性
 */
-(CGFloat)h
{
    return self.frame.size.height;
}


@end
