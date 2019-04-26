//
//  LearnItem.h
//  iOSLowLayer
//
//  Created by tang on 2019/3/25.
//  Copyright © 2019 itang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, LearnItemType)
{
    LearnItemTypeRunStopRunLoop,
    LearnItemTypeLivedThread,
    LearnItemTypeSynExecuteTaskInMainQueue, // 在主队列中异步执行任务
    LearnItemTypeAsynExecuteTaskInMainQueue, // 在主队列中同步执行任务
    LearnItemTypeDeadlockWhenSynExecuteTaskInSerialQueue, // 在串行队列中同步执行任务的死锁问题
    LearnItemTypeGlobalQueueIsOneQueue, // 在串行队列中同步执行任务的死锁问题
    LearnItemTypePerformDelayUsingTimerOnRunLoop, // 延迟执行是通过在runloop中添加定时器实现的
    LearnItemTypeWaitExitedThread, // 等待退出的线程
    LearnItemTypeGCDGroup, // group
    LearnItemTypeLock, //
    LearnItemTypeReadWriteLock, //
    LearnItemTypeMemoryManager, //
    LearnItemTypeMemoryAddressMap, // 内存地址分布

};

NS_ASSUME_NONNULL_BEGIN

@interface LearnItem : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (assign, nonatomic, readonly) LearnItemType type;

+ (instancetype)learnItemWithType:(int)type title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
