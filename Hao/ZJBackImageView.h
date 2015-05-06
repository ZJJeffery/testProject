//
//  ZJBackImageView.h
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJScreenShotView.h"

@interface ZJBackImageView : ZJScreenShotView
@property (nonatomic, copy) UIImage *image;

-(void)saveViewInPhone;

@end
