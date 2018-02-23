//
//  TimerViewController.m
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController () {
    NSTimer *_timer;
}

@end

@implementation TimerViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%@ called!", [self class]);
        }];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [_timer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 控制器视图将要消失的时候清除 timer 不失为一个好时机。
    [self cleanTimer];
}

- (void)cleanTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
    // 应该在更合适的地方释放掉timer，否则会造成循环引用，导致控制器无法释放
//    [self cleanTimer];
    NSLog(@"%@ dealloc!!!", [self class]);
}


@end
