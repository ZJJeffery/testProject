//
//  UIColor+Extension.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIColor *)colorWithNumber:(int)number
{
    return [UIColor colorArray][number];
}
+(NSArray *)colorArray
{
    NSArray *array = @[[UIColor whiteColor],[UIColor yellowColor],[UIColor redColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor greenColor],[UIColor cyanColor],[UIColor brownColor],[UIColor blueColor],[UIColor blackColor]];
    return array;
}
@end
