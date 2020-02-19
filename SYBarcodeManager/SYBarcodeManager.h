//
//  SYBarcodeManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/19.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYBarcodeManager : NSObject

- (instancetype)init __attribute__((unavailable("init 方法不可用，请用 initWithFrame:view:")));
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)superView;

/// 扫描窗口大小（默认居中，位置是相对于初始化方法中的frame设置）
@property (nonatomic, assign) CGRect scanFrame;

/// 遮罩层颜色（默认半透明）
@property (nonatomic, strong) UIColor *maskColor;
/// 扫描线图标（默认显示，且使用默认图标）
@property (nonatomic, strong) UIImage *scanlineImage;
/// 角线颜色（默认橙色）
@property (nonatomic, strong) UIColor *scanCornerColor;
    
/// 扫描线动画时间（默认1.6秒）
@property (nonatomic, assign) NSTimeInterval scanTimeDuration;

/// 扫描提示语（默认值: 将二维码放入框内，即可自动扫描）
@property (nonatomic, strong) NSString *message;
/// 显示位置（默认0底端，1顶端）
@property (nonatomic, assign) NSInteger messagePosition;
/// 扫描提示语字体大小（默认值: 15）
@property (nonatomic, strong) UIFont *messageFont;
/// 扫描提示语字体颜色（默认值: 透明白）
@property (nonatomic, strong) UIColor *messageColor;

/// 光线强弱值
@property (nonatomic, copy) void (^brightnessComplete)(CGFloat brightness);

#pragma mark - 扫描二维码

/// 退出扫描
- (void)QrcodeScanningCancel;
/// 开始扫描
- (void)QrcodeScanningStart;

/// 开始扫描，初始化及立即开始，扫描结果回调
- (void)QrcodeScanningStart:(void (^)(BOOL isEnable, NSString *result))complete;
/// 开始扫描，初始化未开始
- (void)QrcodeScanningComplete:(void (^)(BOOL isEnable, NSString *result))complete;

#pragma mark - 音效
/// 播放音效
- (void)QrcodeScanningPlaySoundName:(NSString *)name;

#pragma mark - 长按识别二维码

/**
 长按等识别图片二维码
 
 @param image 二维码图片
 @return 识别结果
 */
- (NSString *)QRCodeFromImage:(UIImage *)image;

#pragma mark - 生成二维码

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)QrcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)QrcodeImageWithContent:(NSString *)content size:(CGFloat)size;

#pragma mark - 条形码

/// 生成条形码 条形码尺寸大小
+ (UIImage *)BarcodeImageWithContent:(NSString *)content size:(CGSize)size;

#pragma mark - 闪光灯

/**
 闪光灯的开关

 @param complete 状态回调
 */
- (void)openFlashLightComplete:(void (^)(BOOL hasFlash, BOOL isOpen))complete;

/// 开启灯光
- (void)openFlashLight;
/// 关闭灯光
- (void)closeFlashLight;

@end
