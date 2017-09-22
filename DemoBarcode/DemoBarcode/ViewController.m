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

@property (nonatomic, strong) SYBarcodeManager *scanningBarcode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"二维码的使用";
    
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc] initWithTitle:@"scan" style:UIBarButtonItemStyleDone target:self action:@selector(scanClick:)];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self action:@selector(reloadClick:)];
    self.navigationItem.leftBarButtonItems = @[scanItem, cancelItem, reloadItem];
    
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

#pragma mark - 二维码扫描

- (SYBarcodeManager *)scanningBarcode
{
    if (!_scanningBarcode)
    {
        _scanningBarcode = [[SYBarcodeManager alloc] init];
    }
    
    return _scanningBarcode;
}

- (void)scanClick:(UIBarButtonItem *)item
{
    self.scanningBarcode.scanRadius = 50.0;
    self.scanningBarcode.showScanline = YES;
    self.scanningBarcode.scanlineColor = [UIColor redColor];
    self.scanningBarcode.showScanCorner = YES;
    self.scanningBarcode.scanCornerColor = [UIColor greenColor];
    [self.scanningBarcode barcodeScanningWithFrame:CGRectMake(60.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 60.0 * 2), (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) view:self.view complete:^(NSString *scanResult) {
        
        NSLog(@"scanResult = %@", scanResult);
        [[[UIAlertView alloc] initWithTitle:nil message:scanResult delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
    }];
}

- (void)cancelClick:(UIBarButtonItem *)item
{
    [self.scanningBarcode barcodeScanningCancel];
}

- (void)reloadClick:(UIBarButtonItem *)item
{
    [self.scanningBarcode barcodeScanningStart];
}

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
    
    UIImage *image01 = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:width colorRed:10.0 colorGreen:100.0 colorBlue:50.0];
    
    UIImage *image02 = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:width];
    
    UIImageView *imageview01 = (UIImageView *)[self.view viewWithTag:1000];
    imageview01.image = image01;
    
    UIImageView *imageview02 = (UIImageView *)[self.view viewWithTag:2000];
    imageview02.image = image02;
}

@end
