//
//  CKPlayCell.h
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/24.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKPlayDownLoadButton;

@interface CKPlayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CKPlayDownLoadButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)ck_setDownLoadInfoWithDic:(NSDictionary *)infoDic;

- (void)ck_creatADownLoad;
- (void)ck_pause;
- (void)ck_resume;
@end
