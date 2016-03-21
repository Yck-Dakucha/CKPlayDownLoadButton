//
//  CKPlayDownLoadButton.m
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKPlayDownLoadButton.h"


static const CGFloat kBorderWidth = 3.0;
IB_DESIGNABLE
@interface CKPlayDownLoadButton ()

@property (nonatomic, strong) IBInspectable UIColor *defaultColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat downLoadWidth;

@property (nonatomic, strong) CAShapeLayer *borderShapeLayer;
@property (nonatomic, strong) CAShapeLayer *downLoadShapeLayer;

@end

@implementation CKPlayDownLoadButton


- (void)drawRect:(CGRect)rect {
    [self ck_addBorderLayer];
    [self ck_addDownLoadLayer];
    
}
- (void)layoutSubviews {
    self.backgroundColor = [UIColor clearColor];
    [super layoutSubviews];
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
- (void)ck_addDownLoadLayer {
    if (!_downLoadShapeLayer) {
        _downLoadShapeLayer = [CAShapeLayer layer];
        UIBezierPath *downLoadPath = [UIBezierPath bezierPath];
//        CGFloat downLoadWidth = self.bounds.size.width/8.0;
        if (!self.downLoadWidth || self.downLoadWidth == 0) {
            self.downLoadWidth = kBorderWidth;
        }
        CGFloat radius = self.bounds.size.width/2.0;
        [downLoadPath moveToPoint:CGPointMake(radius - self.downLoadWidth/2.0, radius/2.0)];
        [downLoadPath addLineToPoint:CGPointMake(radius - self.downLoadWidth/2.0, radius + radius/2.0 - sqrt(2) * self.downLoadWidth)];
        [downLoadPath addLineToPoint:CGPointMake(radius/2.0 + self.downLoadWidth/2.0, radius)];
        [downLoadPath addLineToPoint:CGPointMake(radius/2.0 - self.downLoadWidth/2.0, radius)];
        [downLoadPath addLineToPoint:CGPointMake(radius, radius * 3/2.0)];
        [downLoadPath addLineToPoint:CGPointMake(radius + radius/2.0 + self.downLoadWidth/2.0, radius)];
        [downLoadPath addLineToPoint:CGPointMake(radius + radius/2.0 - self.downLoadWidth/2.0, radius)];
        [downLoadPath addLineToPoint:CGPointMake(radius + self.downLoadWidth/2.0, radius + radius/2.0 - sqrt(2) * self.downLoadWidth)];
        [downLoadPath addLineToPoint:CGPointMake(radius + self.downLoadWidth/2.0, radius/2.0)];
        [downLoadPath closePath];
        
        
        _downLoadShapeLayer.path = downLoadPath.CGPath;
//        _downLoadShapeLayer.strokeColor = self.defaultColor ?  self.defaultColor.CGColor : [UIColor redColor].CGColor;
        _downLoadShapeLayer.fillColor = self.defaultColor ?  self.defaultColor.CGColor : [UIColor redColor].CGColor;
//        _downLoadShapeLayer.lineWidth = self.downLoadWidth;
        [self.layer addSublayer:_downLoadShapeLayer];
    }
    
}

@end
