//
//  NSString+Extension.h
//  
//
//  Created by Jiajun Zheng on 15/3/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  判断文字自身需要多少大小
 *
 *  @param maxSize 最大大小限制
 *  @param font    字体样式
 *
 *  @return 大小
 */
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font;
/**
 *  给定一个Document下的文件名，返回该路径
 *
 *  @param fileName 文件名
 *
 *  @return 返回路径
 */
+(NSString *)pathForDocumentWithFileName:(NSString *)fileName;
@end
