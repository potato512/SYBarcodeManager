//
//  ViewController.m
//  DemoBarcode
//
//  Created by zhangshaoyu on 16/6/14.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYBarcodeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"二维码的使用";
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearClick:)];
    UIBarButtonItem *showItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStyleDone target:self action:@selector(showClick:)];
    self.navigationItem.rightBarButtonItems = @[showItem, clearItem];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 10.0 * 2);
    CGFloat height = (([UIScreen mainScreen].bounds.size.height - 64.0 - 10.0 * 3) / 2);
    
    UIImageView *imageview01 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, width, height)];
    [self.view addSubview:imageview01];
//    imageview01.backgroundColor = [UIColor redColor];
    imageview01.tag = 1000;
    
    UIImageView *imageview02 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, (CGRectGetHeight(imageview01.bounds) + 10.0 + 10.0), width, height)];
    [self.view addSubview:imageview02];
//    imageview02.backgroundColor = [UIColor grayColor];
    imageview02.tag = 2000;
}

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
    
    UIImage *image01 = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:width colorRed:10.0 colorGreen:100.0 colorBlue:50.0];
    
    UIImage *image02 = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:width];
    
    UIImageView *imageview01 = (UIImageView *)[self.view viewWithTag:1000];
    imageview01.image = image01;
    
    UIImageView *imageview02 = (UIImageView *)[self.view viewWithTag:2000];
    imageview02.image = image02;
}

@end
