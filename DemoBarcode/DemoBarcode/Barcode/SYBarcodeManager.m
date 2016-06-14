//
//  BarCodeManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/19.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "SYBarcodeManager.h"

typedef void (^SaveToPhotosAlbumComplete)(BOOL isSuccess);
static SaveToPhotosAlbumComplete saveToPhotosAlbumComplete;

@implementation SYBarcodeManager

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
