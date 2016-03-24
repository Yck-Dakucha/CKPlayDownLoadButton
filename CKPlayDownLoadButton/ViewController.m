//
//  ViewController.m
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "ViewController.h"
#import "CKPlayDownLoadButton.h"
#import "CKPlayCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.dataArray = [NSMutableArray arrayWithArray:@[
                                                      @{
                                                        @"title":@"1",
                                                        @"downLoadID":@"1"
                                                          },
                                                      @{
                                                          @"title":@"2",
                                                          @"downLoadID":@"2"
                                                          },
                                                      @{
                                                          @"title":@"3",
                                                          @"downLoadID":@"3"
                                                          },
                                                      @{
                                                          @"title":@"4",
                                                          @"downLoadID":@"4"
                                                          },
                                                      @{
                                                          @"title":@"5",
                                                          @"downLoadID":@"5"
                                                          },
                                                      @{
                                                          @"title":@"6",
                                                          @"downLoadID":@"6"
                                                          },
                                                      @{
                                                          @"title":@"7",
                                                          @"downLoadID":@"7"
                                                          },
                                                      @{
                                                          @"title":@"8",
                                                          @"downLoadID":@"8"
                                                          },
                                                      @{
                                                          @"title":@"9",
                                                          @"downLoadID":@"9"
                                                          },
                                                      @{
                                                          @"title":@"10",
                                                          @"downLoadID":@"10"
                                                          },
                                                      ]];
    
    
    
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  tableView dataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PlayDownLoadCell";
    CKPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CKPlayCell *playCell = (CKPlayCell *)cell;
    NSDictionary *cellModel = self.dataArray[indexPath.row];
    [playCell ck_setDownLoadInfoWithDic:cellModel];
    
    [playCell.playButton ck_setPlayButtonWithLoading:^(CGFloat progressValue) {
        [playCell ck_creatADownLoad];
    } pause:^(CGFloat progressValue) {
        [playCell ck_pause];
    } resume:^(CGFloat progressValue) {
        [playCell ck_resume];
    } complete:^(CGFloat progressValue) {
        NSLog(@" %@ >>>  comlpete!!",cellModel[@"title"]);
    }];
    
}

@end
