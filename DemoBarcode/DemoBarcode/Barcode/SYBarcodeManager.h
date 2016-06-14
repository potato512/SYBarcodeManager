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

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size;

@end
