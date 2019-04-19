//
//  NSLockDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockDemo.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 NSLock是对属性为PTHREAD_MUTEX_NORMAL的pthread_mutex_t的封装
 同一对加锁、解锁必须在同一个线程上调用
 */
@interface NSLockDemo : LockDemo

@end

NS_ASSUME_NONNULL_END
