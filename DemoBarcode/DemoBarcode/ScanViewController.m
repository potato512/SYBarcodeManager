//
//  ScanViewController.m
//  DemoBarcode
//
//  Created by zhangshaoyu on 2017/10/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "ScanViewController.h"
#import "SYBarcodeManager.h"

@interface ScanViewController ()
    
@property (nonatomic, strong) SYBarcodeManager *scanningBarcode;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"二维码扫描";
    
    UIBarButtonItem *startItem = [[UIBarButtonItem alloc] initWithTitle:@"start" style:UIBarButtonItemStyleDone target:self action:@selector(startClick:)];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"cancle" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self action:@selector(reloadClick:)];
    self.navigationItem.rightBarButtonItems = @[startItem, cancleItem, reloadItem];
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
    
}
    
#pragma mark - 二维码扫描
    
- (SYBarcodeManager *)scanningBarcode
{
    if (!_scanningBarcode)
    {
        CGRect rect = CGRectMake(60.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 60.0 * 2), (CGRectGetWidth(self.view.bounds) - 60.0 * 2));
        rect = self.view.bounds;
        _scanningBarcode = [[SYBarcodeManager alloc] initWithFrame:self.view.bounds view:self.view];
    }
    
    return _scanningBarcode;
}

- (void)startClick:(UIBarButtonItem *)item
{
    if (1 == self.type)
    {        

    }
    else if (2 == self.type)
    {
        self.scanningBarcode.maskColor = [UIColor clearColor];
        self.scanningBarcode.scanlineColor = [UIColor redColor];
        self.scanningBarcode.scanCornerColor = [UIColor greenColor];
        
        self.scanningBarcode.scanFrame = CGRectMake(60.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 60.0 * 2), (CGRectGetWidth(self.view.bounds) - 60.0 * 2));
    }
    else if (3 == self.type)
    {
        self.scanningBarcode.maskColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        self.scanningBarcode.scanlineColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];;
        self.scanningBarcode.scanCornerColor = [[UIColor orangeColor] colorWithAlphaComponent:1.0];
        
        self.scanningBarcode.scanFrame = CGRectMake(100.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 100.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 100.0 * 2), (CGRectGetWidth(self.view.bounds) - 100.0 * 2));
    }
    [self.scanningBarcode barcodeScanningStart:^(NSString *scanResult) {
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
    [self.scanningBarcode barcodeScanningStart:^(NSString *scanResult) {
        NSLog(@"scanResult = %@", scanResult);
        [[[UIAlertView alloc] initWithTitle:nil message:scanResult delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
    }];
}
    
@end
