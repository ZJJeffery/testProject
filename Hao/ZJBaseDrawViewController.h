//
//  ZJBaseDrawViewController.h
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJBaseDrawViewController;
@protocol ZJBaseDrawViewControllerDelegate <NSObject>
-(void)baseDrawViewControllerreloadData:(ZJBaseDrawViewController *)baseDrawViewController;

@end

@interface ZJBaseDrawViewController : UIViewController
@property (nonatomic, weak) id<ZJBaseDrawViewControllerDelegate> delegate;
@end
