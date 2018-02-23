//
//  BlockObject.h
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockObject : NSObject

@property (copy, nonatomic) dispatch_block_t block;

@end
