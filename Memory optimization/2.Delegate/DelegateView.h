//
//  DelegateView.h
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DelegateView;

@protocol DelegateViewDelegate <NSObject>

@optional
- (void)delegateViewDidClick:(DelegateView *)delegateView;

@end
typedef id<DelegateViewDelegate> DelegateViewDelegate;

@interface DelegateView : UIView

// 如果此处用 retain 修饰，则添加这个代理方法的控制器就会由于 delegate 没有清空而无法释放，造成内存泄露。
//@property (retain, nonatomic) DelegateViewDelegate delegate;
@property (weak, nonatomic) DelegateViewDelegate delegate;

@end

