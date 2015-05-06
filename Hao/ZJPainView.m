//
//  ZJPainView.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJPainView.h"
#import "ZJBezierPath.h"
#import "UIColor+Extension.h"
#import "UIImage+Extention.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+Extension.h"
@interface ZJPainView ()<UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) ZJBezierPath *path;


@end


@implementation ZJPainView

-(NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

-(void)awakeFromNib
{
    self.width = 4;
    self.color = (int)[UIColor colorArray].count -1;
    self.save = YES;
    self.backgroundColor = [UIColor clearColor];
}

//获取触摸点
-(CGPoint)pointFromTouchSet:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.save = NO;
    
    CGPoint startP = [self pointFromTouchSet:touches];
    // 创建路线
    ZJBezierPath *path = [ZJBezierPath bezierPathWithWidth:self.width WithStartPoint:startP];
    // 添加初始点
    [path moveToPoint:startP];
    // 添加到数组
    [self.paths addObject:path];
    // 记录当前的数组
    self.path = path;
    
    //设置属性
    path.color = self.color;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self pointFromTouchSet:touches];
    // 添加点路径
    [self.path addLineToPoint:point];
    // 重绘
    [self setNeedsDisplay];
}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self setNeedsDisplay];
//}


//画图
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    
    // Drawing code
    for (ZJBezierPath *path in self.paths) {
        [[UIColor colorWithNumber:path.color] set];
        [path stroke];
    }
    
//    if (!CGRectEqualToRect(self.curRect, CGRectZero)) {
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextAddRect(ctx, self.curRect);
//        CGContextClip(ctx);
//    }

    
}

-(void)clearScreen{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)undo
{
    if (self.paths.count != 0) {
        [self.paths removeLastObject];
        [self setNeedsDisplay];
    }
    
}
-(void)saveViewInDocument
{
    if (self.paths == nil) {
        [MBProgressHUD showError:@"亲，您还没画呢"];
        return;
    }
//    // 读取次数
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSInteger fileNumber = [defaults integerForKey:@"fileNumber"];
//    // 存储线条
//    [NSKeyedArchiver archiveRootObject:self.paths toFile:[NSString pathForDocumentWithFileName:[NSString stringWithFormat:@"line%ld",fileNumber]]];
//    // 存储次数
//    [defaults setInteger:fileNumber + 1 forKey:@"fileNumber"];
}

//- (void)addLinePaths
//{
//    if (self.isSave) {
//        if ([self.delegate respondsToSelector:@selector(painViewChoosePath:)]) {
//            self.paths = [self.delegate painViewChoosePath:self];
//            [self setNeedsDisplay];
//        }
//    }else{
//        if ([self.delegate respondsToSelector:@selector(painViewcheckAlertViewSave:)]) {
//            [self.delegate painViewcheckAlertViewSave:self];
//        }
//    }
//}
@end
