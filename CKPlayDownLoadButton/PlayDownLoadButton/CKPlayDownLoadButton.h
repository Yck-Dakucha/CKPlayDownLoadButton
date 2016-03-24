//
//  CKPlayDownLoadButton.h
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CKButtonState) {
    CKButtonStateDefault,  //未下载状态
    CKButtonStateLoading,  //下载中
    CKButtonStatePause,    //暂停
    CKButtonStateResume,   //恢复下载
    CKButtonStateComplete  //下载完成
};

typedef void(^CKButtonStateCallBack)();

@interface CKPlayDownLoadButton : UIView

@property (nonatomic, assign) CKButtonState state;
/**
 *  数据总量,必须设置
 */
@property (nonatomic, assign) IBInspectable CGFloat maxValue;
/**
 *  当前数据值
 */
@property (nonatomic, assign) IBInspectable CGFloat value;
/**
 *  未加载时颜色,默认是红色
 */
@property (nonatomic, strong) IBInspectable UIColor *defaultColor;
/**
 *  加载中时颜色，默认是蓝色
 */
@property (nonatomic, strong) IBInspectable UIColor *LoadingColor;
/**
 *  加载完毕时颜色，默认是绿色
 */
@property (nonatomic, strong) IBInspectable UIColor *CompleteColor;
/**
 *  圆形宽度，默认是3像素
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**
 *  中心加载图形宽度。默认是3像素
 */
@property (nonatomic, assign) IBInspectable CGFloat downLoadWidth;

/**
 *  设置不同状态下的回调
 *
 *  @param loading  下载开始
 *  @param pause    下载暂停
 *  @param resume   暂停后恢复
 *  @param complete 下载完成
 */
- (void)ck_setPlayButtonWithLoading:(CKButtonStateCallBack)loading
                              pause:(CKButtonStateCallBack)pause
                             resume:(CKButtonStateCallBack)resume
                           complete:(CKButtonStateCallBack)complete;

@end
