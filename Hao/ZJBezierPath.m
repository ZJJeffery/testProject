//
//  ZJBezierPath.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJBezierPath.h"
#import "UIColor+Extension.h"
@implementation ZJBezierPath

-(void)setProperties
{
    self.lineCapStyle = kCGLineCapRound;
    self.lineJoinStyle = kCGLineJoinBevel;

}
+(instancetype)bezierPathWithWidth:(NSInteger)width WithStartPoint:(CGPoint)startPoint
{
    ZJBezierPath *path = [[ZJBezierPath alloc] init];
    path.lineWidth = width;
    [path setProperties];
    return path;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.width forKey:@"width"];
    [aCoder encodeInteger:self.color forKey:@"color"];
    [aCoder encodeCGPoint:self.startPoint forKey:@"startPoint"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.width = [aDecoder decodeIntegerForKey:@"width"];
        self.color = (int)[aDecoder decodeIntegerForKey:@"color"];
        self.startPoint = [aDecoder decodeCGPointForKey:@"startPoint"];
    }
    return self;
}

@end
