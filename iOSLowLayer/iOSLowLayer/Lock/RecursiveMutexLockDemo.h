//
//  RecursiveMutexLockDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/14.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockDemo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecursiveMutexLockDemo : LockDemo

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
