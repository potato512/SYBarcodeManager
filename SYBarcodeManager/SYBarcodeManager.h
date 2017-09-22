//
//  BarCodeManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/19.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYBarcodeManager : NSObject

/// 是否显示扫描线，默认NO不显示
@property (nonatomic, assign) BOOL showScanline;
/// 扫描线颜色，默认灰色
@property (nonatomic, strong) UIColor *scanlineColor;
/// 是否显示角线，默认NO不显示
@property (nonatomic, assign) BOOL showScanCorner;
/// 角线颜色，默认黑色
@property (nonatomic, strong) UIColor *scanCornerColor;
/// 扫描线动画时间，默认1.6秒
@property (nonatomic, assign) NSTimeInterval scanTimeDuration;
/// 圆角，默认方角
@property (nonatomic, assign) CGFloat scanRadius;

#pragma mark - 扫描二维码

/**
 *  扫描二维码
 *
 *  @param rect     扫描框frame属性
 *  @param view     扫描框父视图
 *  @param complete 扫描结果回调
 */
- (void)barcodeScanningWithFrame:(CGRect)rect view:(UIView *)view complete:(void (^)(NSString *scanResult))complete;

/// 退出扫描
- (void)barcodeScanningCancel;

/// 重新开始扫描
- (void)barcodeScanningStart;

#pragma mark - 生成二维码

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size;

@end
