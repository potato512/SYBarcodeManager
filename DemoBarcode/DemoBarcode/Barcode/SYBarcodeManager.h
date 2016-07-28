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

#pragma mark - 生成二维码

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size;

@end
