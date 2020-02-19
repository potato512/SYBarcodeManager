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
    
    UIButton *scanButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    scanButton.tag = 1000;
    scanButton.selected = YES;
    [scanButton setTitle:@"开始" forState:UIControlStateNormal];
    [scanButton setTitle:@"退出" forState:UIControlStateSelected];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [scanButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [scanButton addTarget:self action:@selector(scanClick:) forControlEvents:UIControlEventTouchUpInside];
    //
    UIButton *lightButton = [[UIButton alloc] initWithFrame:CGRectMake(60.0, 0.0, 40.0, 40.0)];
    [lightButton setTitle:@"开灯" forState:UIControlStateNormal];
    [lightButton setTitle:@"关灯" forState:UIControlStateSelected];
    [lightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [lightButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [lightButton addTarget:self action:@selector(lightClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 40.0)];
    buttonView.userInteractionEnabled = YES;
    buttonView.backgroundColor = [UIColor greenColor];
    [buttonView addSubview:scanButton];
    [buttonView addSubview:lightButton];
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    
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
    if (1 == self.type)
    {
        
    }
    else if (2 == self.type)
    {
        self.scanningBarcode.message = @"扫描框对准二维码";
        self.scanningBarcode.messagePosition = 1;
        self.scanningBarcode.messageFont = [UIFont systemFontOfSize:20.0];
        self.scanningBarcode.messageColor = [UIColor redColor];
        
        self.scanningBarcode.maskColor = [UIColor clearColor];
        self.scanningBarcode.scanCornerColor = [UIColor greenColor];
        self.scanningBarcode.scanlineImage = nil;
        
        self.scanningBarcode.scanFrame = CGRectMake(60.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 60.0 * 2), (CGRectGetWidth(self.view.bounds) - 60.0 * 2));
    }
    else if (3 == self.type)
    {
        self.scanningBarcode.maskColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        self.scanningBarcode.scanCornerColor = [[UIColor orangeColor] colorWithAlphaComponent:1.0];
        self.scanningBarcode.scanFrame = CGRectMake(100.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 100.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 100.0 * 2), (CGRectGetWidth(self.view.bounds) - 100.0 * 2));
    }
    
    __weak ScanViewController *weakSelf = self;
    // 方法1
//    [self.scanningBarcode QrcodeScanningStart:^(BOOL isEnable, NSString *result) {
//        NSString *message = result;
//        if (isEnable) {
//            message = result;
//        } else {
//            message = @"设备不支持";
//        }
//        [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
//    }];
    
    // 方法2
    [self.scanningBarcode QrcodeScanningComplete:^(BOOL isEnable, NSString *result) {
        //
        NSString *message = result;
        if (isEnable) {
            message = result;
        } else {
            message = @"设备不支持";
        }
        [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
    }];
     [self.scanningBarcode QrcodeScanningStart];
}

- (void)scanClick:(UIButton *)button
{
    if (button.selected) {
        button.selected = NO;
        [self.scanningBarcode QrcodeScanningCancel];
    } else {
        button.selected = YES;
        // 方法1
//        [self.scanningBarcode QrcodeScanningStart:^(BOOL isEnable, NSString *result) {
//            NSString *message = result;
//            if (isEnable) {
//                message = result;
//
//                button.selected = !button.selected;
//            } else {
//                message = @"设备不支持";
//            }
//            [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
//        }];
        
        // 方法2
        [self.scanningBarcode QrcodeScanningStart];
    }
}

- (void)lightClick:(UIButton *)button
{
    [self.scanningBarcode openFlashLightComplete:^(BOOL hasFlash, BOOL isOpen) {
        if (hasFlash) {
            button.selected = isOpen;
        } else {
            [[[UIAlertView alloc] initWithTitle:nil message:@"设备不支持" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
        }
    }];
}

- (void)showLight:(BOOL)show
{
    if (show) {
        [self.scanningBarcode openFlashLight];
    }
}

#pragma mark - 二维码扫描
    
- (SYBarcodeManager *)scanningBarcode
{
    if (_scanningBarcode == nil) {
        CGRect rect = CGRectMake(60.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 60.0 * 2), (CGRectGetWidth(self.view.bounds) - 60.0 * 2));
        rect = self.view.bounds;
        _scanningBarcode = [[SYBarcodeManager alloc] initWithFrame:rect view:self.view];
        
        __weak ScanViewController *weakSelf = self;
        _scanningBarcode.brightnessComplete = ^(CGFloat brightness) {
            NSLog(@"光线强度brightness %f", brightness);
            [weakSelf showLight:(brightness > 1.0 ? NO : YES)];
        };
    }
    
    return _scanningBarcode;
}
    
@end
