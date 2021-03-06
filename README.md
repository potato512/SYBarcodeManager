# SYBarcodeManager
二维码操作封装类
* 二维码
  * 扫描识别二维码
  * 长按识别二维码
  * 生成二维码
* 条形码
  * 扫描识别条形码
  * 生成条形码


# 使用介绍
* 自动导入：使用命令`pod 'SYBarcodeManager'`导入到项目中
* 手动导入：或下载源码后，将源码添加到项目中


* 扫描二维码
# 代码示例
~~~ javascript
#import "SYBarcodeManager.h"
~~~

~~~ javascript
// 实例化
self.scanningBarcode = [[SYBarcodeManager alloc] initWithFrame:self.view.bounds view:self.view];
~~~ 

~~~ javascript
// 属性设置
self.scanningBarcode.maskColor = [UIColor clearColor]; // 遮罩层颜色
self.scanningBarcode.scanCornerColor = [UIColor greenColor]; // 四角标颜色
self.scanningBarcode.scanlineImage = [UIImage imageNamed:@"line"]; // 扫描线图标
self.scanningBarcode.scanFrame = CGRectMake(60.0, 100.0, 80.0, 80.0); // 扫描识别区域
~~~ 

~~~ javascript
// 初始化及开始扫描
[self.scanningBarcode QrcodeScanningStart:^(BOOL isEnable, NSString *result) {
    NSString *message = result;
    if (isEnable) {
        message = result;
    } else {
        message = @"设备不支持";
    }
    [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
}];
~~~ 

~~~ javascript
// 初始化未开始扫描
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
~~~

~~~ javascript
// 开始扫描
[self.scanningBarcode QrcodeScanningStart];
~~~ 

~~~ javascript
// 结束扫描
[self.scanningBarcode QrcodeScanningCancel];
~~~

~~~ javascript
// 闪光灯开关回调
[self.scanningBarcode openFlashLightComplete:^(BOOL hasFlash, BOOL isOpen) {
    if (hasFlash) {
        
    } else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"设备不支持" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
    }
}];
~~~

~~~ javascript
// 闪光灯开启
[self.scanningBarcode openFlashLight];
~~~ 

~~~ javascript
// 闪光灯关闭
[self.scanningBarcode closeFlashLight];
~~~ 

~~~ javascript
// 光线强弱回调
self.scanningBarcode.brightnessComplete = ^(CGFloat brightness) {
    NSLog(@"光线强度brightness %f", brightness);
};
~~~ 

~~~ javascript
/// 播放音效
[self.scanningBarcode QrcodeScanningPlaySoundName:@"success.mp3"];
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
* 20200407
  * 版本号：2.3.0
  * carsh闪退修改
    * 新增闪光灯功能硬件是否支持判断
    
* 20200219
  * 版本号：2.2.1
  * 功能优化
    * 扫码速度优化
    * 手势缩放扫描图片
    * 光线识别

* 20190329
  * 版本号：2.1.9 2.2.0
  * 异常修改
    * 摄像头隐私权限屏蔽后crash修复

* 20190308
  * 版本号：2.1.8
  * 功能优化
    * 扫描条形码

* 20190221
  * 版本号：2.1.6 2.1.7
  * 功能优化
    * 新增闪光灯
    * 启动扫描判断设备回调
  * 异常修复
    * 退出扫描时异常
    
* 20190220
  * 版本号：2.1.5
  * 异常修改
    * 扫码位置异常
  * 优化
    * 先判断是否有摄像头
    * 提示信息
      * 位置设置
      * 字体颜色
      * 字体大小

* 20181120
  * 版本号：2.1.1 2.1.2
  * 修改异常

* 20181016
  * 版本号：2.1.0
  * 功能完善
    * 扫描线条改成图标
    * 扫描线条动画改成上下往返
    
* 20180918
  * 版本号：2.0.1
  * 功能添加
    * 条形码生成
    
* 20171020
  * 版本号：2.0.0
  * 功能优化
    * 扫描方法优化
    * 属性设置优化
    * 扫描界面优化

* 20170922
  * 版本号：1.1.0
  * 新增功能属性
    * 停止扫描后重新开始扫描
    * 扫描线属性

* 20170921
  * 版本号：1.0.0
  * 源码与Demo分离



