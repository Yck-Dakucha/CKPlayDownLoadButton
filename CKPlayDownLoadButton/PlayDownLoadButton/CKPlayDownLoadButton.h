//
//  CKPlayDownLoadButton.h
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CKButtonState) {
    CKButtonStateDefault,
    CKButtonStateLoading,
    CKButtonStatePause,
    CKButtonStateResume,
    CKButtonStateComplete
};

typedef void(^CKButtonStateCallBack)();

@interface CKPlayDownLoadButton : UIView

@property (nonatomic, assign) CKButtonState state;

@property (nonatomic, assign) IBInspectable CGFloat maxValue;
@property (nonatomic, assign) IBInspectable CGFloat value;

- (void)ck_setPlayButtonWithLoading:(CKButtonStateCallBack)loading pause:(CKButtonStateCallBack)pause resume:(CKButtonStateCallBack)resume complete:(CKButtonStateCallBack)complete;

@end
