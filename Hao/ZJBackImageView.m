//
//  ZJBackImageView.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJBackImageView.h"
#import "UIImage+Extention.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+Extension.h"
@implementation ZJBackImageView

-(void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
    
}
//-(void)saveView
//{
//   UIImage *finalImage =  [UIImage captureShotWithView:self inRect:self.curRect];
//    // 保存到手机相册
//    // 注意保存完成之后的回调方法,不能乱写
//    UIImageWriteToSavedPhotosAlbum(finalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//}
//
//// 保存相册成功之后的回调方法
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (error) {
//        // 保存失败
//        [MBProgressHUD showError:@"保存失败"];
//    }else{
//        // 保存成功
//        [MBProgressHUD showSuccess:@"保存成功"];
//        
//    }
//}

-(void)drawRect:(CGRect)rect
{
    CGFloat w = self.frame.size.width;;
    CGFloat h;
    CGFloat x = 0;
    CGFloat y;
    CGFloat times;
    if (self.image.size.width != 0) {
       times = self.image.size.height / self.image.size.width;
    }
    h = w * times;
    y =(self.frame.size.height - h) * 0.5;
    CGRect imageRect = CGRectMake(x, y, w, h);
    self.curRect = imageRect;
    
    [self.image drawInRect:imageRect];
}
-(void)saveViewInPhone
{
    
    // 保存到手机相册
    // 注意保存完成之后的回调方法,不能乱写
    if (self.image == nil) {
        return;
    }
    UIImage *finalImagePoto = [self captureShotImage];
    UIImageWriteToSavedPhotosAlbum(finalImagePoto, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    UIImage *finalImage = [self changeImageSize:finalImagePoto];
    
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYYMMDDHHmmss";
    NSString *fileName = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:date]];
    
    NSString *path = [NSString pathForDocumentWithFileName:@"pictures.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:array];
    [tmp addObject:fileName];
    [tmp writeToFile:path atomically:YES];
    
//    // 读取次数
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSInteger fileNumber = [defaults integerForKey:@"fileNumber"];
    NSData *data = UIImagePNGRepresentation(finalImage);
//
//    
    [data writeToFile:[NSString pathForDocumentWithFileName:fileName] atomically:YES];
//    // 存储次数
//    [defaults setInteger:fileNumber + 1 forKey:@"fileNumber"];
//
}


-(UIImage *)changeImageSize:(UIImage *)image{
    CGSize size = CGSizeMake(image.size.width * 0.5, image.size.height * 0.5);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGRect rect = (CGRect){{0,0},size};
    [image drawInRect:rect];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}


-(UIImage *)captureShotImage
{
    CGRect rect;
    if (CGRectEqualToRect(self.curRect, CGRectZero)) {
        rect = self.frame;
    }else
    {
        rect = self.curRect;
    }
    return [UIImage captureShotWithView:self inRect:rect];
}

// 保存相册成功之后的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        // 保存失败
        [MBProgressHUD showError:@"保存失败"];
    }else{
        // 保存成功
        [MBProgressHUD showSuccess:@"保存成功"];
        
    }
}

@end
