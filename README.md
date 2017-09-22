# SYBarcodeManager
二维码操作封装类

* 扫描二维码
# 代码示例
~~~ javascript
#import "SYBarcodeManager.h"
~~~

~~~ javascript
self.scanningBarcode = [[SYBarcodeManager alloc] init];

self.scanningBarcode.scanRadius = 50.0;
self.scanningBarcode.showScanline = YES;
self.scanningBarcode.scanlineColor = [UIColor redColor];
self.scanningBarcode.showScanCorner = YES;
self.scanningBarcode.scanCornerColor = [UIColor greenColor];

[self.scanningBarcode barcodeScanningWithFrame:CGRectMake(60.0, (CGRectGetHeight(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) / 2, (CGRectGetWidth(self.view.bounds) - 60.0 * 2), (CGRectGetWidth(self.view.bounds) - 60.0 * 2)) view:self.view complete:^(NSString *scanResult) {

NSLog(@"scanResult = %@", scanResult);

}];
~~~

# 扫描二维码效果图

![codeScan.gif](./images/codeScan.gif) 


* 生成用户自定义内容的二维码，可以自定义颜色和大小。

# 代码示例
~~~ javascript
#import "SYBarcodeManager.h"
~~~

~~~ javascript
// 方法1 用户自定义颜色
UIImage *image = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:200.0 colorRed:10.0 colorGreen:100.0 colorBlue:50.0];
// 方法2 黑色颜色
UIImage *image = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:200.0];
~~~

# 生成二维码效果图

![codeSave.gif](./images/codeSave.gif) 


# 修改完善
* 20170922
  * 版本号：1.1.0
  * 新增功能属性
    * 停止扫描后重新开始扫描
    * 扫描线属性

~~~ javascript
/// 重新开始扫描
- (void)barcodeScanningStart;

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

~~~

* 20170921
  * 版本号：1.0.0
  * 源码与Demo分离



