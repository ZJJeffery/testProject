//
//  ZJBezierPath.h
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBezierPath : UIBezierPath<NSCoding>
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) int color;

+(instancetype)bezierPathWithWidth:(NSInteger)width WithStartPoint:(CGPoint)startPoint;

-(void)setProperties;
@end
