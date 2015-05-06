//
//  ZJGuide.h
//  Hao
//
//  Created by Jiajun Zheng on 15/4/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJGuide : NSObject
@property (nonatomic, copy) NSString *image1;
@property (nonatomic, copy) NSString *image2;
//
//@property (nonatomic, assign) CGFloat x;
//@property (nonatomic, assign) CGFloat y;
//@property (nonatomic, assign) CGFloat w;
//@property (nonatomic, assign) CGFloat h;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)guideWithDic:(NSDictionary *)dic;

+(NSArray *)guideWithList;
@end
