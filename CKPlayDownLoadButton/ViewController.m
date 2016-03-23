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

@property (nonatomic, strong) CKPlayDownLoadButton *codebutton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.codebutton = [[CKPlayDownLoadButton alloc] initWithFrame:CGRectMake(100, 100, 120, 200)];
    [self.view addSubview:self.codebutton];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerbegin) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer setFireDate:[NSDate distantFuture]];
    
    [self.codebutton setState:CKButtonStateDefault];
    self.codebutton.maxValue = 100;
    self.codebutton.value = 14;
    [self.codebutton ck_setPlayButtonWithLoading:^{
        [timer setFireDate:[NSDate date]];
    }pause:^{
        [timer setFireDate:[NSDate distantFuture]];
    }resume:^{
        [timer setFireDate:[NSDate date]];
    } complete:^{
        [timer invalidate];
        NSLog(@"code >>> complete");
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.playButton ck_setPlayButtonWithLoading:^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.slider.alpha = 1.0;
        }];
        NSLog(@"Loading");
    } pause:^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.slider.alpha = 0;
        }];
        NSLog(@"Pause");
    } resume:^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.slider.alpha = 1.0;
        }];
        NSLog(@"Resume");
    } complete:^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.slider.alpha = 0.0;
        }];
        NSLog(@"Complete");
    }];
}

- (void)timerbegin {
    self.codebutton.value += 5;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.playButton.value = sender.value;
}

@end
