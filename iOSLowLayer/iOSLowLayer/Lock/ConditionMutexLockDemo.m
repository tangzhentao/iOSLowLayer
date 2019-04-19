//
//  ConditionMutexLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/18.
//  Copyright © 2019 itang. All rights reserved.
//

#import "ConditionMutexLockDemo.h"
#import <pthread.h>


@interface ConditionMutexLockDemo ()

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) pthread_mutex_t mutexLock; // 自旋锁
@property (assign, nonatomic) pthread_cond_t condition; // 条件


@end

@implementation ConditionMutexLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 初始化互斥锁属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
        
        // 初始化互斥锁
        pthread_mutex_init(&_mutexLock, &attr);
        // 释放互斥锁属性
        pthread_mutexattr_destroy(&attr);
        
        // 初始化条件
        pthread_cond_init(&_condition, NULL);
        
        _dataArray = [NSMutableArray array];

    }
    return self;
}

- (void)dealloc
{
    // 释放互斥锁
    pthread_mutex_destroy(&_mutexLock);
    // 释放互斥锁属性
}

/*!
 先上锁再添加数据，之后发信号，最后解锁
 */
- (void)addData
{
    // 加锁
    pthread_mutex_lock(&_mutexLock);
    NSLog(@"%@ > 加锁", [NSThread currentThread].name);

    // 添加数据
    [_dataArray addObject:@"test data"];
    NSLog(@"%@ > 添加了一条数据", [NSThread currentThread].name);
    
    // 单发信号：疏通(unblock)一个等待条件_condition的线程
    pthread_cond_signal(&_condition);
    NSLog(@"%@ > 单发了信号", [NSThread currentThread].name);

    // 广播信号：疏通所有等待条件_condition的线程
//    pthread_cond_broadcast(&_condition);
//    NSLog(@"%@ > 广播了信号", [NSThread currentThread].name);
    
    sleep(3);

    // 解锁
    pthread_mutex_unlock(&_mutexLock);
    
    NSLog(@"%@ > 解锁", [NSThread currentThread].name);

}

/*!
 有数据再删除，没数据时等待，直到有数据可删，有数据了立马删除一条；
 */
- (void)removeData
{
    // 加锁
    pthread_mutex_lock(&_mutexLock);
    
    if (0 == _dataArray.count)
    {
        // 解锁并睡眠，收到条件发来的信号时唤醒并加锁
        NSLog(@"%@ > 睡觉", [NSThread currentThread].name);
        pthread_cond_wait(&_condition, &_mutexLock);
        NSLog(@"%@ > 醒了", [NSThread currentThread].name);

        if (0 == _dataArray.count)
        {
            NSLog(@"%@ > 睡觉", [NSThread currentThread].name);
            
            /*
             解锁并睡眠，收到条件发来的信号时唤醒并加锁，
             如果锁还被被发信号的线程解开，那就继续睡眠等待锁被解开。拿到被解开的锁后，立刻上锁；
             */
            pthread_cond_wait(&_condition, &_mutexLock);
            NSLog(@"%@ > 醒了", [NSThread currentThread].name);
        }
    }
    // 添加数据
    [_dataArray removeLastObject];
    NSLog(@"%@ > 删除一条数据", [NSThread currentThread].name);

    // 解锁
    pthread_mutex_unlock(&_mutexLock);

}

@end
