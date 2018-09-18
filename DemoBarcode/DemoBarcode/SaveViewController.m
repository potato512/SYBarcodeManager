//
//  SaveViewController.m
//  DemoBarcode
//
//  Created by zhangshaoyu on 2017/10/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "SaveViewController.h"
#import "SYBarcodeManager.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"二维码生成";
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearClick:)];
    UIBarButtonItem *showItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStyleDone target:self action:@selector(showClick:)];
    self.navigationItem.rightBarButtonItems = @[showItem, clearItem];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}
    
- (void)setUI
{
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 10.0 * 2);
    CGFloat height = (([UIScreen mainScreen].bounds.size.height - 64.0 - 10.0 * 3) / 2);
    
    UIImageView *imageview01 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, width, height)];
    [self.view addSubview:imageview01];
    imageview01.tag = 1000;
    
    UIImageView *imageview02 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, (CGRectGetHeight(imageview01.bounds) + 10.0 + 10.0), width, height)];
    [self.view addSubview:imageview02];
    imageview02.tag = 2000;
}
    
#pragma mark - 二维码扫描

#pragma mark - 二维码生成

- (void)clearClick:(UIBarButtonItem *)item
{
    UIImageView *imageview01 = (UIImageView *)[self.view viewWithTag:1000];
    imageview01.image = nil;
    
    UIImageView *imageview02 = (UIImageView *)[self.view viewWithTag:2000];
    imageview02.image = nil;
}

- (void)showClick:(UIBarButtonItem *)item
{
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 10.0 * 2);
    
    UIImage *imageQrcode = [SYBarcodeManager QrcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:width colorRed:10.0 colorGreen:100.0 colorBlue:50.0];
//    UIImage *imageQrcode = [SYBarcodeManager QrcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:width];
    UIImageView *imageview01 = (UIImageView *)[self.view viewWithTag:1000];
    imageview01.image = imageQrcode;
    
    UIImage *imageBarcode = [SYBarcodeManager BarcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:CGSizeMake(width, width)];
    UIImageView *imageview02 = (UIImageView *)[self.view viewWithTag:2000];
    imageview02.image = imageBarcode;
}

@end
