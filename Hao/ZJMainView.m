//
//  ZJMainView.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJMainView.h"

@implementation ZJMainView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage *image = [UIImage imageNamed:@"mainBackground"];
    [image drawInRect:rect];
}


@end
