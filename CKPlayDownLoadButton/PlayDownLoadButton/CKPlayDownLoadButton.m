//
//  CKPlayDownLoadButton.m
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKPlayDownLoadButton.h"


#define kRadius self.bounds.size.width/2.0

static const CGFloat kBorderWidth = 3.0;

static const NSString *kLoadingCBKey = @"LoadingCallBack";
static const NSString *kPauseCBKey = @"PauseCallBack";
static const NSString *kResumeCBKey = @"ResumeCallBack";
static const NSString *kCompleteCBKey = @"CompleteCallBack";

IB_DESIGNABLE
@interface CKPlayDownLoadButton ()

@property (nonatomic, strong) IBInspectable UIColor *defaultColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat downLoadWidth;

@property (nonatomic, strong) CAShapeLayer *borderShapeLayer;
@property (nonatomic, strong) CAShapeLayer *downLoadShapeLayer;
@property (nonatomic, strong) CAShapeLayer *loadingShapeLayer;
@property (nonatomic, strong) CAShapeLayer *CompleteShapeLayer;

@property (nonatomic, strong) UIBezierPath *downLoadPath;
@property (nonatomic, strong) UIBezierPath *downLoadingPath;
@property (nonatomic, strong) UIBezierPath *loadingPath;

@property (nonatomic, assign) CGFloat tempAngle;

@property (nonatomic, strong) NSMutableDictionary *callBackDic;



@end

@implementation CKPlayDownLoadButton


- (void)drawRect:(CGRect)rect {
    [self ck_addBorderLayer];
    [self ck_addDownLoadLayer];
    
}
- (void)layoutSubviews {
    self.backgroundColor = [UIColor clearColor];
//    self.state = CKButtonStateDefault;
    [super layoutSubviews];
}
- (UIBezierPath *)downLoadPath {
    if (!_downLoadPath) {
        _downLoadPath = [UIBezierPath bezierPath];
        if (!self.downLoadWidth || self.downLoadWidth == 0) {
            self.downLoadWidth = kBorderWidth;
        }
        [_downLoadPath moveToPoint:CGPointMake(kRadius - self.downLoadWidth/2.0, kRadius/2.0)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius - self.downLoadWidth/2.0, kRadius + kRadius/2.0 - sqrt(2) * self.downLoadWidth)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius/2.0 + self.downLoadWidth/2.0, kRadius)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius/2.0 - self.downLoadWidth/2.0, kRadius)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius, kRadius * 3/2.0)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius + kRadius/2.0 + self.downLoadWidth/2.0, kRadius)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius + kRadius/2.0 - self.downLoadWidth/2.0, kRadius)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius + self.downLoadWidth/2.0, kRadius + kRadius/2.0 - sqrt(2) * self.downLoadWidth)];
        [_downLoadPath addLineToPoint:CGPointMake(kRadius + self.downLoadWidth/2.0, kRadius/2.0)];
        [_downLoadPath closePath];
    }
    return _downLoadPath;
}

- (UIBezierPath *)downLoadingPath {
    if (!_downLoadingPath) {
        _downLoadingPath = [UIBezierPath bezierPath];
        if (!self.downLoadWidth || self.downLoadWidth == 0) {
            self.downLoadWidth = kBorderWidth;
        }
        [_downLoadingPath moveToPoint:CGPointMake(kRadius * 3/4.0 + self.downLoadWidth/2.0, kRadius/2.0)];
        [_downLoadingPath addLineToPoint:CGPointMake(kRadius* 3/4.0 + self.downLoadWidth/2.0, kRadius * 3/2.0)];
        [_downLoadingPath addLineToPoint:CGPointMake(kRadius * 3/4.0 - self.downLoadWidth/2.0, kRadius * 3/2.0)];
        [_downLoadingPath addLineToPoint:CGPointMake(kRadius * 3/4.0 - self.downLoadWidth/2.0, kRadius/2.0)];
        [_downLoadingPath closePath];
        
        [_downLoadingPath moveToPoint:CGPointMake(kRadius * 5/4.0 - self.downLoadWidth/2.0, kRadius/2.0)];
        [_downLoadingPath addLineToPoint:CGPointMake(kRadius * 5/4.0 - self.downLoadWidth/2.0, kRadius * 3/2.0)];
        [_downLoadingPath addLineToPoint:CGPointMake(kRadius * 5/4.0 + self.downLoadWidth/2.0, kRadius * 3/2.0)];
        [_downLoadingPath addLineToPoint:CGPointMake(kRadius * 5/4.0 + self.downLoadWidth/2.0, kRadius/2.0)];
        [_downLoadingPath closePath];
    }
    return _downLoadingPath;
}

- (CAShapeLayer *)CompleteShapeLayer {
    if (!_CompleteShapeLayer) {
        _CompleteShapeLayer = [CAShapeLayer layer];
    }
    return _CompleteShapeLayer;
}

- (UIBezierPath *)loadingPath {
    if (!_loadingPath) {
        _loadingPath = [UIBezierPath bezierPath];
    }
    return _loadingPath;
}

#pragma mark -  添加圆框
- (void)ck_addBorderLayer {
    if (!_borderShapeLayer) {
        _borderShapeLayer = [CAShapeLayer layer];
        CGFloat minSide = MIN(self.bounds.size.width, self.bounds.size.height);
        CGRect borderRect = CGRectMake(0, 0, minSide, minSide);
        _borderShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:borderRect].CGPath;
        _borderShapeLayer.strokeColor = self.defaultColor ?  self.defaultColor.CGColor : [UIColor redColor].CGColor;
        _borderShapeLayer.lineWidth = self.borderWidth ? self.borderWidth : kBorderWidth;
        _borderShapeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_borderShapeLayer];
    }
}
#pragma mark -  添加下载路径
- (void)ck_addDownLoadLayer {
    if (!_downLoadShapeLayer) {
        _downLoadShapeLayer = [CAShapeLayer layer];
        _downLoadShapeLayer.path = self.downLoadPath.CGPath;
        _downLoadShapeLayer.fillColor = self.defaultColor ?  self.defaultColor.CGColor : [UIColor redColor].CGColor;
        [self.layer addSublayer:_downLoadShapeLayer];
    }
}
- (void)ck_addLoadingLayer {
    if (!_loadingShapeLayer) {
        _loadingShapeLayer = [CAShapeLayer layer];
        _loadingShapeLayer.lineWidth = self.borderWidth ? self.borderWidth : kBorderWidth;
        _loadingShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingShapeLayer.strokeColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:_loadingShapeLayer];
    }
}

#pragma mark -  动画切换
- (void)ck_switchButtonStateFrom:(UIBezierPath *)fromPath toPath:(UIBezierPath *)toPath animated:(BOOL)animated {
     NSString * const kAnimationKey = @"CKButtonAnimationKey";
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        animation.timingFunction = timingFunction;
        
        [animation setRemovedOnCompletion:NO];
        [animation setFillMode:kCAFillModeForwards];
        
        animation.duration = 0.3;
        animation.fromValue = (__bridge id _Nullable)(fromPath.CGPath);
        animation.toValue = (__bridge id _Nullable)(toPath.CGPath);
        [self.downLoadShapeLayer addAnimation:animation forKey:kAnimationKey];
    }else {
        [self.downLoadShapeLayer removeAnimationForKey:kAnimationKey];
        self.downLoadShapeLayer.path = toPath.CGPath;
    }
}
#pragma mark -  点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self ck_switchButtonStateFrom:self.downLoadPath toPath:self.downLoadingPath animated:YES];
    if (self.state == CKButtonStateDefault) {
        
        [self ck_addLoadingLayer];
        self.state = CKButtonStateLoading;
    }else if (self.state == CKButtonStateLoading) {
        self.state = CKButtonStatePause;
        
    }else if (self.state == CKButtonStatePause) {
    
        self.state = CKButtonStateResume;
        
    }
}

#pragma mark -  处理状
- (void)setState:(CKButtonState)state {
    _state = state;
    CKButtonStateCallBack callBack = nil;
    switch (state) {
        case CKButtonStateDefault:
            break;
        case CKButtonStateLoading:
            callBack = self.callBackDic[kLoadingCBKey];
            break;
        case CKButtonStatePause:
            callBack = self.callBackDic[kPauseCBKey];
            break;
        case CKButtonStateResume:
            callBack = self.callBackDic[kResumeCBKey];
            break;
        case CKButtonStateComplete:
            [self.loadingShapeLayer removeFromSuperlayer];
            callBack = self.callBackDic[kCompleteCBKey];
            break;
        default:
            break;
    }
    if (callBack) {
        callBack();
    }
    
}
#pragma mark -  设置loading值

- (void)setValue:(CGFloat)value {
    if (self.state == CKButtonStateComplete) {
        return;
    }
    _value = value;
    CGFloat endAngle = 2 * M_PI * value/self.maxValue;
    if (endAngle == 2 * M_PI) {
        self.state = CKButtonStateComplete;
        return;
    }
    CGPoint center = CGPointMake(kRadius, kRadius);
    [self.loadingPath removeAllPoints];
    [self.loadingPath addArcWithCenter:center radius:kRadius startAngle:0.0 endAngle:endAngle clockwise:YES];
    self.loadingShapeLayer.path = self.loadingPath.CGPath;
}

- (void)ck_setPlayButtonWithLoading:(CKButtonStateCallBack)loading pause:(CKButtonStateCallBack)pause resume:(CKButtonStateCallBack)resume complete:(CKButtonStateCallBack)complete {
    self.callBackDic = [NSMutableDictionary dictionary];
    if (loading) {
        [self.callBackDic setObject:loading forKey:kLoadingCBKey];
    }
    if (pause) {
        [self.callBackDic setObject:pause forKey:kPauseCBKey];
    }
    if (resume) {
        [self.callBackDic setObject:resume forKey:kResumeCBKey];
    }
    if (complete) {
        [self.callBackDic setObject:complete forKey:kCompleteCBKey];
    }
}
@end
