//
//  BlockViewController.m
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import "BlockViewController.h"
#import "BlockObject.h"

@interface BlockViewController ()

// self 对 object 对象进行强引用
@property (strong, nonatomic) BlockObject *object;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) dispatch_block_t block;

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    _object = [[BlockObject alloc] init];

    // 先将 self 转成 weak，之后在 block 内部转成 strong 使用，是常见的解决方案。
    __weak typeof(self)weakSelf = self;
    [_object setBlock:^{
        __strong typeof(self)strongSelf = weakSelf;
        strongSelf.index = 1;
        
        // object 对象对 self （成员变量或属性）进行强引用，就会造成循环引用
    //        _index = 1;
    //        self.index = 1;
    }];
    
    // 此处不会发生内存泄露，因为这个block是局部的，self对此block不存在强引用。
//    [self executeBlock:^{
//        self.index = 1;
//    }];
    
    // 此处会发生内存泄露，因为 self 添加了全局 block，self 对此 block 存在强引用。
//    [self executeBlock2:^{
//        self.index = 1;
//    }];
}

- (void)executeBlock:(dispatch_block_t)block {
    if (block) {
        block();
    }
}

- (void)executeBlock2:(dispatch_block_t)block {
    // 这个 _block 全局变量就是内存泄露的原因，如果 block 内部使用weakSelf就会打破这个循环了。
    _block = block;
    if (block) {
        block();
    }
}

- (void)dealloc {
    NSLog(@"%@ dealloc!!!", [self class]);
}


@end
