# BarcodeManager
二维码操作封装类

* 生成用户自定义内容的二维码，可以自定义颜色和大小。

#使用示例
~~~ javascript
#import "SYBarcodeManager.h"
~~~

~~~ javascript
// 方法1 用户自定义颜色
UIImage *image = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:200.0 colorRed:10.0 colorGreen:100.0 colorBlue:50.0];
// 方法2 黑色颜色
UIImage *image = [SYBarcodeManager barcodeImageWithContent:@"https://github.com/potato512/BarcodeManager" size:200.0];
~~~

#效果图
* 生成前

![clear](./images/clear.png) 
* 生成后

![barcode](./images/barcode.png) 
