//
//  ZJGuide.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJGuide.h"

@implementation ZJGuide
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)guideWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+(NSArray *)guideWithList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"guideImages" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ZJGuide *model = [ZJGuide guideWithDic:dic];
        [temp addObject:model];
    }
    return temp;
}
@end
