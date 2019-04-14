//
//  RecursiveMutexLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/14.
//  Copyright © 2019 itang. All rights reserved.
//

#import "RecursiveMutexLockDemo.h"
#import <pthread.h>

@interface RecursiveMutexLockDemo ()

@property (assign, nonatomic) pthread_mutex_t mutexLock; // 互斥锁

@end

@implementation RecursiveMutexLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 初始化为普通互斥锁
//        [self initLock:&_mutexLock lockType:PTHREAD_MUTEX_NORMAL];
        // 初始化为递归互斥锁
        [self initLock:&_mutexLock lockType:PTHREAD_MUTEX_RECURSIVE];
    }
    return self;
}

- (void)initLock:(pthread_mutex_t *)lock lockType:(int)lockType
{
    // 初始化互斥锁的属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, lockType);
    
    // 初始化互斥锁
    pthread_mutex_init(lock, &attr);
    
    // 销毁互斥锁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)mainTask
{
    /*
     如果使用默认的互斥锁，在执行子任务时将导致死锁。因为在子任务上锁时，发现互斥锁已经被上锁，
     所以子任务就在等主任务解锁，而主任务在子任务执行完才能解锁。这样就导致了死锁。
     
     此时可以通过主任务和子任务使用不同的锁来解决。也可以通过使用递归锁来解决。
     
     递归锁允许：在同一线程中，对已经上锁的锁，再次上锁后继续执行代码，而不是等待解锁后执行代码；
     */
    pthread_mutex_lock(&_mutexLock);
    
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    [self subTask];
    
    pthread_mutex_unlock(&_mutexLock);
}
// 子任务
- (void)subTask
{
    pthread_mutex_lock(&_mutexLock);
    
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    pthread_mutex_unlock(&_mutexLock);
}

/*!
 递归任务
 */
- (void)recursiveTask
{
    /*
     如果使用默认的互斥锁，在第二次调用该方法时将导致死锁。。
     
     此时可以通过使用递归锁来解决。
     
     递归锁允许：在同一线程中，对已经上锁的锁，再次上锁后继续执行代码，而不是等待解锁后执行代码；
     */
    pthread_mutex_lock(&_mutexLock);
    
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));

    static int count = 0;
    if (count < 10)
    {
        ++count;
        [self recursiveTask];
    }
    
    pthread_mutex_unlock(&_mutexLock);
}

@end
