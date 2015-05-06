//
//  ZJGuideCollectionViewController.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJGuideCollectionViewController.h"
#import "ZJGuideCell.h"
#import "ZJGuide.h"
#define kITEMCOUNT (4)

@interface ZJGuideCollectionViewController ()
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *guides;
@property (nonatomic, weak) UIImageView *image1;
@property (nonatomic, weak) UIImageView *image2;
@property (nonatomic, weak) UIImageView *image3;
@property (nonatomic, weak) UIView *btnView;
@property (nonatomic, weak) UIPageControl *page;
@end

@implementation ZJGuideCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSArray *)guides
{
    if (_guides ==nil) {
        _guides = [ZJGuide guideWithList];

        
    }
    return _guides;
}
//-(void)setGuidesFrames
//{
//    [self setGuide0];
//    [self setGuide1];
//    [self setGuide2];
//    [self setGuide3];
//}
//
//-(void)setGuide0{
//    ZJGuide *guide = self.guides[0];
//    guide.x = 0;
//    guide.y = 0;
//    guide.w = 0;
//    guide.h = 0;
//}
//
//-(void)setGuide1{
//    ZJGuide *guide = self.guides[0];
//    guide.x = 0;
//    guide.y = 0;
//    guide.w = 0;
//    guide.h = 0;
//    
//}
//-(void)setGuide2{
//    ZJGuide *guide = self.guides[0];
//    guide.x = 0;
//    guide.y = 0;
//    guide.w = 0;
//    guide.h = 0;
//}
//-(void)setGuide3{
//    ZJGuide *guide = self.guides[0];
//    guide.x = 0;
//    guide.y = 0;
//    guide.w = 0;
//    guide.h = 0;
//}

-(NSArray *)images
{
    if (_images == nil) {
        NSMutableArray *tmp = [NSMutableArray array];
        for (int i = 0; i< kITEMCOUNT; i++) {
            [tmp addObject:[NSString stringWithFormat:@"guide%d.JPG",i]];
        }
        _images = tmp;
    }
    return _images;
}
-(void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        [self setSizeOfImage:0];
    }];
    CGFloat w = 100;
    CGFloat x = (self.view.frame.size.width - w) * 0.5;
    CGFloat y = self.view.frame.size.height * 0.9;
    
    self.page.frame =CGRectMake(x, y, w, 44);
}

-(void)setSizeOfImage:(NSInteger)number
{
    CGFloat w1 = [UIImage imageNamed:[self.guides[number] image1]].size.width;
    CGFloat h1 = [UIImage imageNamed:[self.guides[number] image1]].size.height;
    CGFloat x1;
    CGFloat y1;
    switch (number) {
        case 0:
            x1 = self.collectionView.contentOffset.x + (self.view.frame.size.width - w1) * 0.5;
            y1 = self.view.frame.size.height * 0.2;
            break;
        case 1:
            x1 = self.collectionView.contentOffset.x + self.view.frame.size.width * 0.1;
            y1 = self.view.frame.size.height * 0.2;
            break;
        case 2:
            x1 = self.collectionView.contentOffset.x + self.view.frame.size.width * 0.1;
            y1 = self.view.frame.size.height * 0.2;
            break;
        case 3:
            x1 = self.collectionView.contentOffset.x + self.view.frame.size.width * 0.1;
            y1 = self.view.frame.size.height * 0.1;
            break;
            
        default:
            break;
    }

    self.image1.frame = CGRectMake(x1, y1, w1, h1);
    
    CGFloat w2 = [UIImage imageNamed:[self.guides[number] image2]].size.width;
    CGFloat h2 = [UIImage imageNamed:[self.guides[number] image2]].size.height;
    CGFloat x2;
    CGFloat y2;
    switch (number) {
        case 0:
            x2 = self.collectionView.contentOffset.x + (self.view.frame.size.width - w2) * 0.5;
            y2 = self.view.frame.size.height * 0.8;
            break;
        case 1:
            x2 = self.collectionView.contentOffset.x + self.view.frame.size.width * 0.6;
            y2 = self.view.frame.size.height * 0.8;
            break;
        case 2:
            x2 = self.collectionView.contentOffset.x + self.view.frame.size.width * 0.6;
            y2 = self.view.frame.size.height * 0.85;
            break;
        case 3:
            x2 = self.collectionView.contentOffset.x + (self.view.frame.size.width - w2) * 0.5;
            y2 = self.view.frame.size.height * 0.8;
            break;
            
        default:
            break;
    }
    self.image2.frame = CGRectMake(x2, y2, w2, h2);
    
    if (number == 3) {
        self.image3.hidden = NO;
        CGFloat w3 = [UIImage imageNamed:@"hao"].size.width;
        CGFloat h3 = [UIImage imageNamed:@"hao"].size.height;
        CGFloat x3 = self.collectionView.contentOffset.x + self.view.frame.size.width * 0.4;
        CGFloat y3 = self.view.frame.size.height * 0.1;
        self.image3.frame = CGRectMake(x3, y3, w3, h3);
        
        self.btnView.hidden = NO;
        CGFloat wb = [UIImage imageNamed:@"enter"].size.width;
        CGFloat hb = [UIImage imageNamed:@"enter"].size.height;
        CGFloat xb = self.collectionView.contentOffset.x + (self.view.frame.size.width - w2) * 0.5;
        CGFloat yb = self.view.frame.size.height * 0.71;
        self.btnView.frame = CGRectMake(xb, yb, wb, hb);
        [[self.btnView.subviews lastObject] setFrame:self.btnView.bounds];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    // Register cell classes
    [self.collectionView registerClass:[ZJGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.guides[0] image1]]];
    [self.collectionView addSubview:image1];
    self.image1 = image1;
    self.image1.frame = CGRectZero;
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.guides[0] image2]]];
    [self.collectionView addSubview:image2];
    self.image2 = image2;
    self.image2.frame = CGRectZero;
    
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hao"]];
    [self.collectionView addSubview:image3];
    self.image3 = image3;
    self.image3.frame = CGRectZero;
    self.image3.hidden = YES;
    
    UIView *btnView = [[UIView alloc] init];
    [self.collectionView addSubview:btnView];
    self.btnView = btnView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnView addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
    self.btnView.frame = CGRectZero;
    self.btnView.backgroundColor = [UIColor colorWithRed:0.322 green:0.591 blue:1.000 alpha:0.270];
    self.btnView.layer.cornerRadius = 10;
    self.btnView.layer.masksToBounds = YES;
    
    self.btnView.hidden = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIPageControl *page= [[UIPageControl alloc] init];
    [self.view addSubview:page];
    self.page = page;
    
    page.currentPage = 0;
    page.numberOfPages = kITEMCOUNT;
    
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor blueColor];
    
    
}

-(void)btnClick
{
    UIStoryboard *mainSt = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainVc =  [mainSt instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.imageName = self.images[indexPath.row];
    
    return cell;
}

#pragma mark - scollView代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = (NSInteger)self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    ZJGuide *guide = self.guides[page];
    self.image1.image = [UIImage imageNamed:guide.image1];
    self.image2.image = [UIImage imageNamed:guide.image2];
    self.image1.frame = CGRectZero;
    self.image2.frame = CGRectZero;
    [UIView animateWithDuration:0.5 animations:^{
        [self setSizeOfImage:page];
    }];
    self.page.currentPage = page;
}



@end
