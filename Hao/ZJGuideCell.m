//
//  ZJGuideCell.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJGuideCell.h"

@interface ZJGuideCell ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ZJGuideCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end
