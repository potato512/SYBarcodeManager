//
//  BarCodeManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/19.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "SYBarcodeManager.h"
#import <AVFoundation/AVFoundation.h>

typedef void (^ScanningComplete)(NSString *scanResult);
//static ScanningComplete scanningComplete;

static CGFloat const widthline = 3.0;
static CGFloat const heightline = 20.0;

typedef void (^SaveToPhotosAlbumComplete)(BOOL isSuccess);
static SaveToPhotosAlbumComplete saveToPhotosAlbumComplete;

@interface SYBarcodeManager () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UIView *scanView;

@property (nonatomic, strong) AVCaptureSession *avSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *avLayer;

@property (nonatomic, strong) UIImageView *cornerline01;
@property (nonatomic, strong) UIImageView *cornerline02;
@property (nonatomic, strong) UIImageView *cornerline03;
@property (nonatomic, strong) UIImageView *cornerline04;
@property (nonatomic, strong) UIImageView *cornerline05;
@property (nonatomic, strong) UIImageView *cornerline06;
@property (nonatomic, strong) UIImageView *cornerline07;
@property (nonatomic, strong) UIImageView *cornerline08;
@property (nonatomic, strong) UIImageView *scanline;

@property (nonatomic, copy) ScanningComplete scanningComplete;

@end

@implementation SYBarcodeManager


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _showScanline = NO;
        _scanlineColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
        
        _showScanCorner = NO;
        _scanCornerColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _scanTimeDuration = 1.6;
        
        _scanRadius = 0.0;
    }
    return self;
}

#pragma mark - 扫描二维码

/// 退出扫描
- (void)barcodeScanningCancel
{
    [self.avSession stopRunning];
    if (self.avLayer.superlayer)
    {
        [self.avLayer removeFromSuperlayer];
    }
    
    [self scanlineAnimationStop];
}

/// 重新开始扫描
- (void)barcodeScanningStart
{
    if (self.avLayer.superlayer == nil)
    {
        if (self.scanView)
        {
            [self.scanView.layer insertSublayer:self.avLayer above:0];
        }
    }

    // 动画扫描线
    [self scanlineAnimationStart];
    
    // 开始捕获
    [self.avSession startRunning];
}

/**
 *  扫描二维码
 *
 *  @param rect     扫描框frame属性
 *  @param view     扫描框父视图
 *  @param complete 扫描结果回调
 */
- (void)barcodeScanningWithFrame:(CGRect)rect view:(UIView *)view complete:(void (^)(NSString *scanResult))complete
{
    if (view)
    {
        self.scanView.frame = rect;
        [view addSubview:self.scanView];
    }
    // 圆角
    self.scanView.layer.cornerRadius = self.scanRadius;
    self.scanView.layer.masksToBounds = YES;
    self.scanView.clipsToBounds = YES;
    
    // 扫描框的位置和大小
    self.avLayer.frame = self.scanView.bounds;
    if (self.scanView)
    {
        [self.scanView.layer insertSublayer:self.avLayer above:0];
    }
    
    self.scanningComplete = [complete copy];
    
    // 显示扫描线
    [self scanlineAnimationStart];
    
    // 开始捕获
    [self.avSession startRunning];
}

- (UIView *)scanView
{
    if (_scanView == nil)
    {
        _scanView = [UIView new];
        _scanView.backgroundColor = [UIColor clearColor];
    }
    return _scanView;
}

- (AVCaptureSession *)avSession
{
    if (!_avSession)
    {
        // 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 异常判断
        if (device == nil)
        {
            // 设备无摄像时
            [[[UIAlertView alloc] initWithTitle:nil message:@"未获取到摄像设备" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
            return nil;
        }
        
        // 创建输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        // 创建输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        // 设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 初始化链接对象
        _avSession = [[AVCaptureSession alloc] init];
        // 高质量采集率
        [_avSession setSessionPreset:AVCaptureSessionPresetHigh];
        
        [_avSession addInput:input];
        [_avSession addOutput:output];
        
        // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    
    return _avSession;
}

- (AVCaptureVideoPreviewLayer *)avLayer
{
    if (!_avLayer)
    {
        _avLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.avSession];
        _avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    
    return _avLayer;
}

#pragma mark cornerline

- (UIImageView *)cornerline01
{
    if (_cornerline01 == nil)
    {
        _cornerline01 = [[UIImageView alloc] init];
    }
    return _cornerline01;
}

- (UIImageView *)cornerline02
{
    if (_cornerline02 == nil)
    {
        _cornerline02 = [[UIImageView alloc] init];
    }
    return _cornerline02;
}

- (UIImageView *)cornerline03
{
    if (_cornerline03 == nil)
    {
        _cornerline03 = [[UIImageView alloc] init];
    }
    return _cornerline03;
}

- (UIImageView *)cornerline04
{
    if (_cornerline04 == nil)
    {
        _cornerline04 = [[UIImageView alloc] init];
    }
    return _cornerline04;
}

- (UIImageView *)cornerline05
{
    if (_cornerline05 == nil)
    {
        _cornerline05 = [[UIImageView alloc] init];
    }
    return _cornerline05;
}

- (UIImageView *)cornerline06
{
    if (_cornerline06 == nil)
    {
        _cornerline06 = [[UIImageView alloc] init];
    }
    return _cornerline06;
}

- (UIImageView *)cornerline07
{
    if (_cornerline07 == nil)
    {
        _cornerline07 = [[UIImageView alloc] init];
    }
    return _cornerline07;
}

- (UIImageView *)cornerline08
{
    if (_cornerline08 == nil)
    {
        _cornerline08 = [[UIImageView alloc] init];
    }
    return _cornerline08;
}

#pragma mark scanline

- (UIImageView *)scanline
{
    if (_scanline == nil)
    {
        _scanline = [[UIImageView alloc] init];
    }
    return _scanline;
}

- (void)reloadline
{
    if (_showScanline)
    {
        if (self.scanline.superview == nil)
        {
            self.scanline.frame = CGRectMake(0.0, 0.0, self.scanView.frame.size.width, widthline);
            
            [self.scanView addSubview:self.scanline];
        }
        
        self.scanline.backgroundColor = _scanlineColor;
    }
    
    if (_showScanCorner)
    {
        if (self.cornerline01.superview == nil)
        {
            self.cornerline01.frame = CGRectMake(0.0, 0.0, widthline, heightline);
            self.cornerline02.frame = CGRectMake(0.0, 0.0, heightline, widthline);
            self.cornerline03.frame = CGRectMake((self.scanView.frame.size.width - heightline), 0.0, heightline, widthline);
            self.cornerline04.frame = CGRectMake((self.scanView.frame.size.width - widthline), 0.0, widthline, heightline);
            self.cornerline05.frame = CGRectMake(0.0, (self.scanView.frame.size.height - heightline), widthline, heightline);
            self.cornerline06.frame = CGRectMake(0.0, (self.scanView.frame.size.height - widthline), heightline, widthline);
            self.cornerline07.frame = CGRectMake((self.scanView.frame.size.width - heightline), (self.scanView.frame.size.height - widthline), heightline, widthline);
            self.cornerline08.frame = CGRectMake((self.scanView.frame.size.width - widthline), (self.scanView.frame.size.height - heightline), widthline, heightline);
            
            [self.scanView addSubview:self.cornerline01];
            [self.scanView addSubview:self.cornerline02];
            [self.scanView addSubview:self.cornerline03];
            [self.scanView addSubview:self.cornerline04];
            [self.scanView addSubview:self.cornerline05];
            [self.scanView addSubview:self.cornerline06];
            [self.scanView addSubview:self.cornerline07];
            [self.scanView addSubview:self.cornerline08];
        }
        
        self.cornerline01.backgroundColor = _scanCornerColor;
        self.cornerline02.backgroundColor = _scanCornerColor;
        self.cornerline03.backgroundColor = _scanCornerColor;
        self.cornerline04.backgroundColor = _scanCornerColor;
        self.cornerline05.backgroundColor = _scanCornerColor;
        self.cornerline06.backgroundColor = _scanCornerColor;
        self.cornerline07.backgroundColor = _scanCornerColor;
        self.cornerline08.backgroundColor = _scanCornerColor;
    }
    
    if (0.0 < self.scanRadius)
    {
        // 有圆角时
        if (self.showScanCorner)
        {
            if (self.cornerline01.superview)
            {
                [self.cornerline01 removeFromSuperview];
                [self.cornerline02 removeFromSuperview];
                [self.cornerline03 removeFromSuperview];
                [self.cornerline04 removeFromSuperview];
                [self.cornerline05 removeFromSuperview];
                [self.cornerline06 removeFromSuperview];
                [self.cornerline07 removeFromSuperview];
                [self.cornerline08 removeFromSuperview];
            }
        }
    }
    else
    {
        // 无圆角时
        if (self.showScanCorner)
        {
            if (self.cornerline01.superview == nil)
            {
                [self.scanView addSubview:self.cornerline01];
                [self.scanView addSubview:self.cornerline02];
                [self.scanView addSubview:self.cornerline03];
                [self.scanView addSubview:self.cornerline04];
                [self.scanView addSubview:self.cornerline05];
                [self.scanView addSubview:self.cornerline06];
                [self.scanView addSubview:self.cornerline07];
                [self.scanView addSubview:self.cornerline08];
            }
        }
    }
}

- (void)scanlineAnimationStart
{
    [self reloadline];
    
    if (_showScanline)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_scanTimeDuration];
        [UIView setAnimationRepeatCount:MAXFLOAT];
        //
        CGRect rectline = self.scanline.frame;
        rectline.origin.y = (self.scanView.frame.size.height - widthline);
        self.scanline.frame = rectline;
        //
        [UIView commitAnimations];
    }
}

- (void)scanlineAnimationStop
{
    if (_showScanline)
    {
        if (self.scanline.superview)
        {
            [self.scanline removeFromSuperview];
        }
        if (self.cornerline01.superview)
        {
            [self.cornerline01 removeFromSuperview];
            [self.cornerline02 removeFromSuperview];
            [self.cornerline03 removeFromSuperview];
            [self.cornerline04 removeFromSuperview];
            [self.cornerline05 removeFromSuperview];
            [self.cornerline06 removeFromSuperview];
            [self.cornerline07 removeFromSuperview];
            [self.cornerline08 removeFromSuperview];
        }
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

// 通过代理方法获取扫描到的结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"%s",__func__);
    
    if (metadataObjects.count > 0)
    {
        // [session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex: 0];
        // 输出扫描字符串
        NSLog(@"metadataObject = %@，value = %@", metadataObject, metadataObject.stringValue);
        
        // 停止扫描
        [self.avSession stopRunning];
        
        // 停止扫描线
        [self scanlineAnimationStop];
        
        if (self.scanningComplete)
        {
            NSString *scanResult = metadataObject.stringValue;
            self.scanningComplete(scanResult);
        }
    }
}

#pragma mark - 生成二维码

// 根据字符内容生成二维码图片CIImage
+ (CIImage *)barcodeCIImageWithContent:(NSString *)content
{
    NSData *barCodeData = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [filter setValue:barCodeData forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return filter.outputImage;
}

// 二维码图片UIImage
+ (UIImage *)barcodeImageWithCIImage:(CIImage *)ciimage size:(CGFloat)size
{
    CGRect extent = CGRectIntegral(ciimage.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciimage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

// 内存管理
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

/// 黑白二维码转成指定颜色
+ (UIImage *)barcodeImageChangeColor:(UIImage *)image colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue
{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)
        {
            // 将白色变成透明
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue
{
    CIImage *ciimage = [self barcodeCIImageWithContent:content];
    UIImage *image = [self barcodeImageWithCIImage:ciimage size:size];
    image = [self barcodeImageChangeColor:image colorRed:red colorGreen:green colorBlue:blue];
    return image;
}

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size
{
    UIImage *image = [self barcodeImageWithContent:content size:size colorRed:0.0 colorGreen:0.0 colorBlue:0.0];
    return image;
}

@end
