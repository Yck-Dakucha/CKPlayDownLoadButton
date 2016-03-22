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
@property (weak, nonatomic) IBOutlet CKPlayDownLoadButton *playButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CKPlayDownLoadButton *playButton = [[CKPlayDownLoadButton alloc] initWithFrame:CGRectMake(100, 100, 120, 200)];
    [self.view addSubview:playButton];
    
    [self.playButton ck_setPlayButtonWithLoading:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.slider.alpha = 1.0;
        }];
        NSLog(@"Loading");
    } pause:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.slider.alpha = 0;
        }];
        NSLog(@"Pause");
    } resume:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.slider.alpha = 1.0;
        }];
        NSLog(@"Resume");
    } complete:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.slider.alpha = 0.0;
        }];
        NSLog(@"Complete");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.playButton.value = sender.value;
}

@end
