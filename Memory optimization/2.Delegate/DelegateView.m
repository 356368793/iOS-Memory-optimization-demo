//
//  DelegateView.m
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import "DelegateView.h"

@implementation DelegateView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(delegateViewDidClick:)]) {
        [self.delegate delegateViewDidClick:self];
    }
}

@end
