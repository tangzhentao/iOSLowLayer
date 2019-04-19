//
//  NSRecursiveLockDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockDemo.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 NSRecursiveLock是对属性为PTHREAD_MUTEX_RECURSIVE的pthread_mutex_t的封装
 */
@interface NSRecursiveLockDemo : LockDemo

/*!
 主任务: 包含子任务
 */
- (void)mainTask;

/*!
 递归任务
 */
- (void)recursiveTask;

@end

NS_ASSUME_NONNULL_END
