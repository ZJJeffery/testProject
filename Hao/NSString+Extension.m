//
//  NSString+Extension.m
//  
//
//  Created by Jiajun Zheng on 15/3/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
#pragma mark - 计算字符长度
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font;
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
#pragma mark - 返回Document下文件名的路径
+(NSString *)pathForDocumentWithFileName:(NSString *)fileName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:fileName];
}
@end
