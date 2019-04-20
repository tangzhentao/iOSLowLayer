//
//  SynchronizedDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/20.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockDemo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @synchronized() {} 是对递归互斥锁(PTHREAD_MUTEX_RECURSIVE pthread_mutex_t)的封装
 */

@interface SynchronizedDemo : LockDemo

- (void)testSynchronized;

@end

NS_ASSUME_NONNULL_END
