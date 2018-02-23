//
//  DelegateViewController.m
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import "DelegateViewController.h"
#import "DelegateView.h"

@interface DelegateViewController () <DelegateViewDelegate>

@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    DelegateView *v = [[DelegateView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor purpleColor];
    v.delegate = self;
    [self.view addSubview:v];
}

- (void)delegateViewDidClick:(DelegateView *)delegateView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

-(void)dealloc {
    NSLog(@"%@ dealloc!!!", [self class]);
}


@end
