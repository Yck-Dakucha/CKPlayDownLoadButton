//
//  CKPlayCell.m
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/24.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKPlayCell.h"
#import "CKPlayDownLoadButton.h"

@interface CKPlayCell ()


@property (nonatomic, strong) NSDictionary *downLoadDic;
@property (nonatomic, strong) NSDictionary *downloadingDic;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat loadProgress;

@end

@implementation CKPlayCell

- (void)awakeFromNib {
    // Initialization code
    
    self.downLoadDic = @{
                         
                         @"2":@{
                                 @"maxValue":@"100",
                                 @"value":@"30"
                                 },
                         @"5":@{
                                 @"maxValue":@"100",
                                 @"value":@"30"
                                 },
                         @"10":@{
                                 @"maxValue":@"100",
                                 @"value":@"30"
                                 }
                         };
    
    
    self.downloadingDic = @{
                            
                            @"3":@{
                                    @"maxValue":@"100",
                                    @"value":@"70"
                                    },
                            @"7":@{
                                    @"maxValue":@"100",
                                    @"value":@"5"
                                    }
                            
                            };
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downLoading) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)downLoading {
    self.loadProgress += 10;
    self.playButton.value = self.loadProgress;
}


- (void)ck_setDownLoadInfoWithDic:(NSDictionary *)infoDic {
    self.titleLabel.text = infoDic[@"title"];
    NSString *downLoadID = infoDic[@"downLoadID"];
    
    if (self.downloadingDic[downLoadID]) {
        NSDictionary *loadingInfo = self.downloadingDic[downLoadID];
        self.playButton.state = CKButtonStateLoading;
        self.playButton.maxValue = [loadingInfo[@"maxValue"] floatValue];
        self.loadProgress = [loadingInfo[@"value"] floatValue];
        self.playButton.value = self.loadProgress;
        [self ck_resume];
    }else if (self.downLoadDic[downLoadID]) {
        NSDictionary *loadInfo = self.downLoadDic[downLoadID];
        self.playButton.state = CKButtonStatePause;
        self.playButton.maxValue = [loadInfo[@"maxValue"] floatValue];
        self.loadProgress = [loadInfo[@"value"] floatValue];
        self.playButton.value = self.loadProgress;
    }
    
}

- (void)ck_creatADownLoad {
    self.loadProgress = 0;
    self.playButton.maxValue = 100;
    [self.timer setFireDate:[NSDate date]];
}
- (void)ck_pause {
    [self.timer setFireDate:[NSDate distantFuture]];
}
- (void)ck_resume{
    [self.timer setFireDate:[NSDate date]];
}
@end
