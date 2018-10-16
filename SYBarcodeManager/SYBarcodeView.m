//
//  SYBarcodeView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/10/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "SYBarcodeView.h"

static CGFloat const originXLine = 5.0;
static CGFloat const heightline = 5.0;

@interface SYBarcodeView ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SYBarcodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.opaque = NO;
        
        CGFloat size = ((frame.size.width > frame.size.height ? frame.size.height : frame.size.width) * 0.6);
        _scanFrame = CGRectMake((frame.size.width - size) / 2, (frame.size.width - size) / 2, size, size);
        
        _cornerColor = [[UIColor orangeColor] colorWithAlphaComponent:1.0];
        _scanTimeDuration = 1.6;
    }
    return self;
}
    
- (void)dealloc
{
    NSLog(@"%@ 被释放了...", [self class]);
}

- (void)drawRect:(CGRect)rect
{
    [self addScanView:rect];
    [self addScanLine];
    [self addScanCorner];
}

// 设置中间透明区域
- (void)addScanView:(CGRect)rect
{
    [self.backgroundColor setFill];
    UIRectFill(rect);
    CGRect clearIntersection = CGRectIntersection(_scanFrame, rect);
    [[UIColor clearColor] setFill];
    UIRectFill(clearIntersection);
}

#pragma mark - 扫描区域

// 设置四个角线
- (void)addScanCorner
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, _cornerColor.CGColor);
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    //
	CGPoint upLeftPoints[] = {CGPointMake(self.scanFrame.origin.x, self.scanFrame.origin.y), CGPointMake(self.scanFrame.origin.x + 20.0, self.scanFrame.origin.y), CGPointMake(self.scanFrame.origin.x, self.scanFrame.origin.y), CGPointMake(self.scanFrame.origin.x, self.scanFrame.origin.y + 20.0)};
    CGPoint upRightPoints[] = {CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width) - 20.0, self.scanFrame.origin.y), CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width), self.scanFrame.origin.y), CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width), self.scanFrame.origin.y), CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width), self.scanFrame.origin.y + 20.0)};
    CGPoint belowLeftPoints[] = {CGPointMake(self.scanFrame.origin.x, (self.scanFrame.origin.y + self.scanFrame.size.height)), CGPointMake(self.scanFrame.origin.x, (self.scanFrame.origin.y + self.scanFrame.size.height) - 20.0), CGPointMake(self.scanFrame.origin.x, (self.scanFrame.origin.y + self.scanFrame.size.height)), CGPointMake(self.scanFrame.origin.x + 20.0, (self.scanFrame.origin.y + self.scanFrame.size.height))};
    CGPoint belowRightPoints[] = {CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width), (self.scanFrame.origin.y + self.scanFrame.size.height)), CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width) - 20.0, (self.scanFrame.origin.y + self.scanFrame.size.height)), CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width), (self.scanFrame.origin.y + self.scanFrame.size.height)), CGPointMake((self.scanFrame.origin.x + self.scanFrame.size.width), (self.scanFrame.origin.y + self.scanFrame.size.height) - 20.0)};
    CGContextStrokeLineSegments(ctx, upLeftPoints, 4);
    CGContextStrokeLineSegments(ctx, upRightPoints, 4);
    CGContextStrokeLineSegments(ctx, belowLeftPoints, 4);
    CGContextStrokeLineSegments(ctx, belowRightPoints, 4);
}

#pragma mark - 扫描线

- (UIImageView *)scanline
{
    if (_scanline == nil) {
        _scanline = [[UIImageView alloc] initWithFrame:CGRectZero];
        _scanline.backgroundColor = [UIColor clearColor];
        _scanline.image = [UIImage imageNamed:@"scanner_line"];
    }
    return _scanline;
}

// 设置扫描线
- (void)addScanLine
{
    if (self.scanline.superview == nil)
    {
        [self addSubview:self.scanline];
    }
    
    // 位置
    self.scanline.frame = CGRectMake((self.scanFrame.origin.x + originXLine), self.scanFrame.origin.y, (self.scanFrame.size.width - originXLine * 2), heightline);
    [self scanLineAnimation];
}
   
- (void)reloadBarcodeView
{
    [self addScanView:self.frame];
    [self addScanLine];
    [self addScanCorner];
}

- (void)scanLineAnimation
{
    // 动画
    CGFloat originYLine = self.scanline.frame.origin.y;
    if (originYLine == self.scanFrame.origin.y) {
        // 从上到下
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_scanTimeDuration];
        [UIView setAnimationRepeatCount:MAXFLOAT];
        CGRect rectLine = self.scanline.frame;
        rectLine.origin.y = (self.scanFrame.origin.y + self.scanFrame.size.height - heightline);
        self.scanline.frame = rectLine;
        [UIView commitAnimations];
    } else {
        // 从下到上
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_scanTimeDuration];
        [UIView setAnimationRepeatCount:MAXFLOAT];
        CGRect rectLine = self.scanline.frame;
        rectLine.origin.y = self.scanFrame.origin.y;
        self.scanline.frame = rectLine;
        [UIView commitAnimations];
    }
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:(_scanTimeDuration - 0.1) target:self selector:@selector(scanLineAnimation) userInfo:nil repeats: YES];
    }
}

- (void)scanLineStop
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    CFTimeInterval pausedTime = [self.scanline.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.scanline.layer.speed = 0.0;
    self.scanline.layer.timeOffset = pausedTime;
}

- (void)scanLineStart
{
    [self scanLineAnimation];
    
    CFTimeInterval pausedTime = [self.scanline.layer timeOffset];
    self.scanline.layer.speed = 1.0;
    self.scanline.layer.timeOffset = 0.0;
    self.scanline.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.scanline.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.scanline.layer.beginTime = timeSincePause;
}

@end
