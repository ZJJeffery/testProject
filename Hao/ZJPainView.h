//
//  ZJPainView.h
//  Hao
//
//  Created by Jiajun Zheng on 15/4/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJScreenShotView.h"
@class ZJPainView,ZJBezierPath;

@protocol ZJPainViewDelegate <NSObject>
@optional
-(void)painViewcheckAlertViewSave:(ZJPainView *)painView;
-(NSMutableArray *)painViewChoosePath:(ZJPainView *)painView;
@end


@interface ZJPainView : ZJScreenShotView
@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) int color;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, assign,getter=isSave) BOOL save;

@property (nonatomic, weak) id<ZJPainViewDelegate> delegate;

- (void)clearScreen;
- (void)undo;

- (void)saveViewInDocument;
//- (void)addLinePaths;

@end
