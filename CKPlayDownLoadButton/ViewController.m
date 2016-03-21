//
//  ViewController.m
//  CKPlayDownLoadButton
//
//  Created by Yck on 16/3/21.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "ViewController.h"
#import "CKPlayDownLoadButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CKPlayDownLoadButton *playButton = [[CKPlayDownLoadButton alloc] initWithFrame:CGRectMake(100, 100, 120, 200)];
    [self.view addSubview:playButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
