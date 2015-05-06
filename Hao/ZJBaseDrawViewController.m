//
//  ZJBaseDrawViewController.m
//  Hao
//
//  Created by Jiajun Zheng on 15/4/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZJBaseDrawViewController.h"
#import "DWBubbleMenuButton.h"
#import "ZJBubbleMenuButton.h"
#import "ZJPainView.h"
#import "UIColor+Extension.h"
#import "ZJBackImageView.h"
#import "ZJMainCollectionController.h"
@interface ZJBaseDrawViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZJPainViewDelegate>
@property (weak, nonatomic) IBOutlet ZJBackImageView *imageView;
@property (weak, nonatomic) IBOutlet ZJPainView *painView;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *dos;
@property (nonatomic, strong) NSArray *lines;
@property (nonatomic, weak) ZJBubbleMenuButton *menuTool;
@property (nonatomic, weak) ZJBubbleMenuButton *colorTool;
@property (nonatomic, weak) ZJBubbleMenuButton *lineTool;
@property (nonatomic, assign,getter=isLoad) BOOL load;
@end

@implementation ZJBaseDrawViewController
// 创建菜单栏
-(void)createMenuTool
{
    // 创建操作工具条
    UILabel *homeLabel = [self createHomeButtonView:@"工具"];
    
    ZJBubbleMenuButton *menuTool = [[ZJBubbleMenuButton alloc] initWithFrame:CGRectMake(20.f,
                                                                                        20.f,
                                                                                        homeLabel.frame.size.width,
                                                                                        homeLabel.frame.size.height)
                                                          expansionDirection:DirectionRight];
    menuTool.homeButtonView = homeLabel;
    
    NSArray *array0 =@[@"<-",@"撤",@"清",@"添",@"存",@"读"];
    self.dos = array0;
    [menuTool addButtons:[self createDemoButtonArray:array0]];
    self.menuTool = menuTool;
    [menuTool showButtons];
    [self.view addSubview:menuTool];

}

-(void)createColorTool{
    // 创建色彩工具条
    UILabel *homeLabel = [self createHomeButtonView:@"色彩"];
    
    ZJBubbleMenuButton *colorTool = [[ZJBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                         80.f,
                                                                                         homeLabel.frame.size.width,
                                                                                         homeLabel.frame.size.height)
                                                           expansionDirection:DirectionDown];
    colorTool.homeButtonView = homeLabel;
    //    NSMutableArray *array1 =[NSMutableArray array];
    //    [array1 addObject:[UIColor whiteColor]];
    //    [array1 addObject:[UIColor yellowColor]];
    //    [array1 addObject:[UIColor redColor]];
    //    [array1 addObject:[UIColor purpleColor]];
    //    [array1 addObject:[UIColor orangeColor]];
    //    [array1 addObject:[UIColor magentaColor]];
    //    [array1 addObject:[UIColor greenColor]];
    //    [array1 addObject:[UIColor cyanColor]];
    //    [array1 addObject:[UIColor brownColor]];
    //    [array1 addObject:[UIColor blueColor]];
    //    [array1 addObject:[UIColor blackColor]];
    self.colors = [UIColor colorArray];
    self.painView.colors = [UIColor colorArray];
    [colorTool addButtons:[self createDemoButtonColorArray:self.colors]];
    self.colorTool = colorTool;
    [colorTool showButtons];
    [self.view addSubview:colorTool];
}

-(void)createLineTool
{
    // 创建线条工具条
    UILabel *homeLabel = [self createHomeButtonView:@"线条"];
    
    ZJBubbleMenuButton *lineTool = [[ZJBubbleMenuButton alloc] initWithFrame:CGRectMake(20.f,
                                                                                        80.f,
                                                                                        homeLabel.frame.size.width,
                                                                                        homeLabel.frame.size.height)
                                                          expansionDirection:DirectionDown];
    lineTool.homeButtonView = homeLabel;
    NSArray *arrayline =@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    self.lines = arrayline;
    [lineTool addButtons:[self createDemoButtonArray:arrayline]];
    self.lineTool = lineTool;
//    [lineTool showButtons];
    [self.view addSubview:lineTool];
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (self.menuTool == nil) {
        [self createMenuTool];
    }
    if (self.colorTool == nil) {
        [self createColorTool];
    }
    if (self.lineTool == nil) {
        [self createLineTool];
    }
    if (!self.isLoad) {
        [self loadImage];
        self.load = YES;
    }
}

- (UILabel *)createHomeButtonView:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonColorArray:(NSArray *)array{
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (UIColor *color in array) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = color;
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(colorBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}



- (NSArray *)createDemoButtonArray:(NSArray *)array {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    SEL method = @selector(lintBtn:);
    int i = 0;
    for (NSString *title in array) {
        if ([title isEqualToString:@"<-"]) {
            method = @selector(doBtn:);
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)lintBtn:(UIButton *)sender {
    self.painView.width = (sender.tag + 1) * 2;
}

- (void)doBtn:(UIButton *)sender {
    int index = (int)sender.tag;
    switch (index) {
        case 0:
            [self back];
            break;
        case 1:
            [self.painView undo];
            break;
        case 2:
            [self.painView clearScreen];
            break;
        case 3:
//            [self.painView addLinePaths];
            break;
        case 4:
            [self saveView];
            break;
        case 5:
            [self loadImage];
            break;

        default:
            break;
    }
}

- (void)colorBtn:(UIButton *)sender {
    self.painView.color = (int)sender.tag;
}


-(void)loadImage
{
    // 获取照片
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc] init];
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 设置照片选择器的代理,监听照片选择
    pickerVc.delegate = self;
    
    
    [self presentViewController:pickerVc animated:YES completion:nil];
    
    self.painView.curRect = self.imageView.curRect;
}

-(void)saveView
{
    // 保存视图
    [self.painView saveViewInDocument];
    [self.imageView saveViewInPhone];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

-(void)back
{
    if (self.painView.isSave) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        // 询问用户是否需要保存
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定不保存直接退出么？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@"保存并退出", nil];
        [actionSheet showInView:self.view];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.painView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ActionSheet 代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (buttonIndex == 1){
        [self saveView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if ([self.delegate respondsToSelector:@selector(baseDrawViewControllerreloadData:)]) {
        [self.delegate baseDrawViewControllerreloadData:self];
    }
    [super dismissViewControllerAnimated:flag completion:completion];
}

#pragma mark - ImagePickerController代理
// 当选中一个照片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // 获取选中的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 把选中的照片绘制到画板
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - painView代理方法
-(void)painViewcheckAlertViewSave:(ZJPainView *)painView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"亲，您还木有保存您画得哦！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"就不保存", nil];
    [alertView show];
}
//-(NSMutableArray *)painViewChoosePath:(ZJPainView *)painView
//{
//    //
//    ZJ
////    // 读取线条
////    NSMutableArray *paths =  NSKeyedUnarchiver unarchiveObjectWithFile:[NSString pathForDocumentWithFileName:[NSString stringWithFormat:@"line%ld",fileNumber]
//    
//    
//    return paths;
//}

#pragma mark - AlertView代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"选择线条");
    }
}

@end