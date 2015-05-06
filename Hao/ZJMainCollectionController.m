//
//  ZJMainCollectionController.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJMainCollectionController.h"
#import "NSString+Extension.h"
#import "ZJCollecionCell.h"
#import "ZJBaseDrawViewController.h"
#import "MBProgressHUD+MJ.h"
#import "ZJMainView.h"
#import "ZJPicture.h"
@interface ZJMainCollectionController ()<ZJBaseDrawViewControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flow;
@property (nonatomic, strong) NSCache *pictures;
@property (nonatomic, strong) NSMutableArray *pictureNames;
@property (nonatomic, assign) CGFloat margin;

@end

@implementation ZJMainCollectionController
static NSString *reusedId = @"cell";
-(void)awakeFromNib
{
    self.margin = 10;
    CGFloat width = (self.collectionView.frame.size.width - self.margin * 3) * 0.5;
    CGFloat height = self.collectionView.frame.size.height / self.collectionView.frame.size.width * width;
    self.flow.itemSize = CGSizeMake(width,height);
    self.flow.minimumInteritemSpacing = self.margin;
    self.flow.minimumLineSpacing = self.margin;
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);

}

-(NSMutableArray *)pictureNames
{
    if (_pictureNames == nil) {
        NSString *path = [NSString pathForDocumentWithFileName:@"pictures.plist"];
        _pictureNames = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _pictureNames;
}

-(NSCache *)pictures
{
    if (_pictures == nil) {
        NSCache *cache = [[NSCache alloc] init];
        _pictures = cache;
    }
    return _pictures;
}

-(UIImage *)imageWithName:(NSString *)name{
    NSString *imagePath = [NSString pathForDocumentWithFileName:name];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    return [UIImage imageWithData:data];
}
//-(NSArray *)reloadDataFromFile
//{
//    NSString *path = [NSString pathForDocumentWithFileName:@"pictures.plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    NSMutableArray *tmp = [NSMutableArray array];
//    for (NSString *name in array) {
////        NSString *imagePath = [NSString pathForDocumentWithFileName:name];
////        NSData *data = [NSData dataWithContentsOfFile:imagePath];
////        UIImage *img = [UIImage imageWithData:data];
////        [tmp addObject:img];
//    }
//    return tmp;
//}

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:0.829 green:0.838 blue:0.820 alpha:1.000];
//    [self.collectionView regist
}

#pragma mark - collectionView数据源

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pictureNames.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJCollecionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedId forIndexPath:indexPath];
    NSString *imageName = self.pictureNames[indexPath.item];
    UIImage *img = [self.pictures objectForKey:imageName];
    cell.imageView.image = nil;
    if (img == nil) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *loadimg = [self imageWithName:imageName];
            [self.pictures setObject:loadimg forKey:imageName];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            });
            
        });
        return cell;
    }
    
    cell.imageView.image = img;
    cell.backgroundColor = [UIColor colorWithRed:0.909 green:0.919 blue:0.900 alpha:1.000];
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ZJBaseDrawViewController *nextVc = [segue destinationViewController];
    nextVc.delegate = self;
}
#pragma mark - collectionView代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"你对该图进行哪个改动" delegate:self cancelButtonTitle:@"手贱点错了" destructiveButtonTitle:@"太丑删了" otherButtonTitles:@"还有救修改下", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - ZJBaseDrawViewController代理
-(void)baseDrawViewControllerreloadData:(ZJBaseDrawViewController *)baseDrawViewController
{
    self.pictureNames = nil;
    [self.collectionView reloadData];
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.pictureNames.count -1 inSection:0];
    if (index.row > 0) {
            [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    }

}

#pragma mark - UIActionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *path = [NSString pathForDocumentWithFileName:@"pictures.plist"];
        NSMutableArray *tmp = [NSMutableArray arrayWithContentsOfFile:path];
        NSIndexPath *index = [[self.collectionView indexPathsForSelectedItems] lastObject];
        NSString *imageName = self.pictureNames[index.item];
        [tmp removeObjectAtIndex:index.row];
        [tmp writeToFile:path atomically:YES];
        
        NSString *imagePath = [NSString pathForDocumentWithFileName:imageName];
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:NULL];
        
        self.pictureNames = nil;
        [self.collectionView reloadData];
    }else if(buttonIndex == 1)
    {
        [MBProgressHUD showError:@"没法修改"];
    }
}
@end
