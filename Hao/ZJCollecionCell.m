//
//  ZJCollecionCell.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJCollecionCell.h"
#import "ZJPicture.h"
#import "NSString+Extension.h"

@interface ZJCollecionCell ()

@end

@implementation ZJCollecionCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.imageView.frame = self.bounds;
}

//-(void)setImageName:(NSString *)imageName
//{
//    _imageName = imageName;
////    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSString *imagePath = [NSString pathForDocumentWithFileName:imageName];
//        NSData *data = [NSData dataWithContentsOfFile:imagePath];
//        UIImage *img = [UIImage imageWithData:data];
////        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = img;
//////        });
////    });
//
//    
//}
@end
