//
//  CKPlayDownLoadButton.m
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKPlayDownLoadButton.h"


#define kRadius MIN(self.bounds.size.width, self.bounds.size.height)/2.0
#define kDefaultColor [UIColor redColor]
#define kLoadingColor [UIColor blueColor]
#define kCompleteColor [UIColor greenColor]

static const CGFloat kBorderWidth = 3.0;

static const NSString *kLoadingCBKey  = @"LoadingCallBack";
static const NSString *kPauseCBKey    = @"PauseCallBack";
static const NSString *kResumeCBKey   = @"ResumeCallBack";
static const NSString *kCompleteCBKey = @"CompleteCallBack";

IB_DESIGNABLE
@interface CKPlayDownLoadButton ()

@property (nonatomic, strong) CAShapeLayer *borderShapeLayer;
@property (nonatomic, strong) CAShapeLayer *downLoadShapeLayer;
@property (nonatomic, strong) CAShapeLayer *loadingShapeLayer;

@property (nonatomic, strong) UIBezierPath *downLoadPath;
@property (nonatomic, strong) UIBezierPath *downLoadingPath;
@property (nonatomic, strong) UIBezierPath *loadingBorderPath;
@property (nonatomic, strong) UIBezierPath *pausePath;
@property (nonatomic, strong) UIBezierPath *completePath;

@property (nonatomic, assign) CGFloat tempAngle;

@property (nonatomic, strong) NSMutableDictionary *callBackDic;



@end

@implementation CKPlayDownLoadButton


- (void)drawRect:(CGRect)rect {
    [self ck_addBorderLayer];
    [self ck_addDownLoadLayer];
    [self ck_addLoadingLayer];
}
- (void)layoutSubviews {
    self.backgroundColor = [UIColor clearColor];
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
- (UIBezierPath *)loadingBorderPath {
    if (!_loadingBorderPath) {
        _loadingBorderPath = [UIBezierPath bezierPath];
    }
    return _loadingBorderPath;
}
- (UIBezierPath *)pausePath {
    if (!_pausePath) {
        _pausePath = [UIBezierPath bezierPath];
        if (!self.downLoadWidth || self.downLoadWidth == 0) {
            self.downLoadWidth = kBorderWidth;
        }
        [_pausePath moveToPoint:CGPointMake(kRadius * 3/4.0 - self.downLoadWidth/2.0, kRadius/2.0)];
        [_pausePath addLineToPoint:CGPointMake(kRadius * 3/4.0 - self.downLoadWidth/2.0, kRadius * 3/2.0)];
        [_pausePath addLineToPoint:CGPointMake(kRadius * 3/2.0, kRadius)];
        [_pausePath closePath];
    }
    return _pausePath;
}
- (UIBezierPath *)completePath {
    if (!_completePath) {
        _completePath = [UIBezierPath bezierPath];
        [_completePath moveToPoint:CGPointMake(kRadius * 1/2.0, kRadius)];
        [_completePath addLineToPoint:CGPointMake(kRadius * 1/2.0 - self.downLoadWidth * sqrt(2)/2.0, kRadius + self.downLoadWidth * sqrt(2)/2.0)];
        [_completePath addLineToPoint:CGPointMake(kRadius * 7/8.0, kRadius * 11/8.0 + self.downLoadWidth * sqrt(2))];
        [_completePath addLineToPoint:CGPointMake(kRadius * 13/8.0 + self.downLoadWidth * sqrt(2)/2.0, kRadius * 5/8.0 + self.downLoadWidth * sqrt(2)/2.0)];
        [_completePath addLineToPoint:CGPointMake(kRadius * 13/8.0, kRadius * 5/8.0)];
        [_completePath addLineToPoint:CGPointMake(kRadius * 7/8.0, kRadius * 11/8.0)];
        [_completePath closePath];
    }
    return _completePath;
}

#pragma mark -  添加圆框
- (void)ck_addBorderLayer {
    if (!_borderShapeLayer) {
        _borderShapeLayer = [CAShapeLayer layer];
        CGFloat minSide = MIN(self.bounds.size.width, self.bounds.size.height);
        CGRect borderRect = CGRectMake(0, 0, minSide, minSide);
        _borderShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:borderRect].CGPath;
        if (self.state == CKButtonStateComplete) {
             _borderShapeLayer.strokeColor = self.CompleteColor ?  self.CompleteColor.CGColor : kCompleteColor.CGColor;
        }else {
             _borderShapeLayer.strokeColor = self.defaultColor ?  self.defaultColor.CGColor : kDefaultColor.CGColor;
        }
       
        _borderShapeLayer.lineWidth = self.borderWidth ? self.borderWidth : kBorderWidth;
        _borderShapeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_borderShapeLayer];
    }
}
#pragma mark -  添加下载路径
- (void)ck_addDownLoadLayer {
    if (!_downLoadShapeLayer) {
        _downLoadShapeLayer = [CAShapeLayer layer];
        switch (self.state) {
            case CKButtonStateDefault:
                _downLoadShapeLayer.path = self.downLoadPath.CGPath;
                _downLoadShapeLayer.fillColor = self.defaultColor ?  self.defaultColor.CGColor : kDefaultColor.CGColor;
                break;
            case CKButtonStatePause:
                _downLoadShapeLayer.path = self.pausePath.CGPath;
                _downLoadShapeLayer.fillColor = self.LoadingColor ?  self.LoadingColor.CGColor : kLoadingColor.CGColor;
                break;
            case CKButtonStateLoading:
                _downLoadShapeLayer.path = self.downLoadingPath.CGPath;
                _downLoadShapeLayer.fillColor = self.LoadingColor ?  self.LoadingColor.CGColor : kLoadingColor.CGColor;
                break;
            case CKButtonStateComplete:
                _downLoadShapeLayer.path = self.completePath.CGPath;
                _downLoadShapeLayer.fillColor = self.CompleteColor ?  self.CompleteColor.CGColor : kCompleteColor.CGColor;
                break;
            default:
                _downLoadShapeLayer.path = self.downLoadingPath.CGPath;
                _downLoadShapeLayer.fillColor = self.LoadingColor ?  self.LoadingColor.CGColor : kLoadingColor.CGColor;
                break;
        }
        
        [self.layer addSublayer:_downLoadShapeLayer];
    }
}
- (void)ck_addLoadingLayer {
    if (!_loadingShapeLayer) {
        _loadingShapeLayer = [CAShapeLayer layer];
        _loadingShapeLayer.lineWidth = self.borderWidth ? self.borderWidth : kBorderWidth;
        _loadingShapeLayer.path = self.loadingBorderPath.CGPath;
        _loadingShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingShapeLayer.strokeColor = self.LoadingColor ? self.LoadingColor.CGColor : kLoadingColor.CGColor;
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
    CKButtonStateCallBack callBack = nil;
    
    if (self.state == CKButtonStateDefault) {
        
        self.state = CKButtonStateLoading;
        [self ck_switchButtonStateFrom:self.downLoadPath toPath:self.downLoadingPath animated:YES];
        callBack = self.callBackDic[kLoadingCBKey];
        
    }else if (self.state == CKButtonStateLoading) {
        
        self.state = CKButtonStatePause;
        [self ck_switchButtonStateFrom:self.downLoadingPath toPath:self.pausePath animated:YES];
        callBack = self.callBackDic[kPauseCBKey];
        
    }else if (self.state == CKButtonStatePause) {
        
        self.state = CKButtonStateResume;
        [self ck_switchButtonStateFrom:self.pausePath toPath:self.downLoadingPath animated:YES];
        callBack = self.callBackDic[kResumeCBKey];
    
    }else if (self.state == CKButtonStateResume) {

        self.state = CKButtonStatePause;
        [self ck_switchButtonStateFrom:self.downLoadingPath toPath:self.pausePath animated:YES];
        callBack = self.callBackDic[kPauseCBKey];
        
    }
    if (callBack) {
        callBack();
    }
}

#pragma mark -  处理状
- (void)setState:(CKButtonState)state {
    _state = state;
   
    switch (state) {
        case CKButtonStateDefault:
            self.downLoadShapeLayer.path = self.downLoadPath.CGPath;
            break;
        case CKButtonStateComplete:
            [self ck_switchButtonStateFrom:self.downLoadingPath toPath:self.completePath animated:YES];
            [self.loadingShapeLayer removeFromSuperlayer];
            self.borderShapeLayer.strokeColor = self.CompleteColor ? self.CompleteColor.CGColor : kCompleteColor.CGColor;
            self.downLoadShapeLayer.fillColor = self.CompleteColor ? self.CompleteColor.CGColor : kCompleteColor.CGColor;
            break;
        default:
            self.downLoadShapeLayer.fillColor = self.LoadingColor ? self.LoadingColor.CGColor : kLoadingColor.CGColor;
            break;
    }
}
#pragma mark -  设置loading值

- (void)setValue:(CGFloat)value {
    if (self.state == CKButtonStateComplete) {
        return;
    }
    _value = value;
    CGFloat endAngle = 2 * M_PI * value/self.maxValue;
    if (endAngle >= 2 *M_PI) {
        self.state = CKButtonStateComplete;
        CKButtonStateCallBack callBack = self.callBackDic[kCompleteCBKey];
        if (callBack) {
            callBack();
        }
        return;
    }
    if (value && self.state == CKButtonStateDefault) {
        self.state = CKButtonStatePause;
        [self ck_switchButtonStateFrom:self.pausePath toPath:self.downLoadingPath animated:YES];
        self.downLoadShapeLayer.fillColor = self.LoadingColor ? self.LoadingColor.CGColor : kLoadingColor.CGColor;
    }
    CGPoint center = CGPointMake(kRadius, kRadius);
    [self.loadingBorderPath removeAllPoints];
    [self.loadingBorderPath addArcWithCenter:center radius:kRadius startAngle:0.0 - M_PI / 2.0  endAngle:endAngle - M_PI / 2.0 clockwise:YES];
    self.loadingShapeLayer.path = self.loadingBorderPath.CGPath;
}
#pragma mark -  外部调用方法
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
