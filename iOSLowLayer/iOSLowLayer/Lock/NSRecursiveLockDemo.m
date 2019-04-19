//
//  NSRecursiveLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "NSRecursiveLockDemo.h"

@interface NSRecursiveLockDemo ()

@property (strong, nonatomic) NSRecursiveLock *lock; // 互斥锁

@end

@implementation NSRecursiveLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _lock = [[NSRecursiveLock alloc] init];;
    }
    return self;
}

- (void)mainTask
{
    /*
     如果使用默认的互斥锁，在执行子任务时将导致死锁。因为在子任务上锁时，发现互斥锁已经被上锁，
     所以子任务就在等主任务解锁，而主任务在子任务执行完才能解锁。这样就导致了死锁。
     
     此时可以通过主任务和子任务使用不同的锁来解决。也可以通过使用递归锁来解决。
     
     递归锁允许：在同一线程中，对已经上锁的锁，再次上锁后继续执行代码，而不是等待解锁后执行代码；
     */
    [_lock lock];
    
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    [self subTask];
    
    [_lock unlock];
}
// 子任务
- (void)subTask
{
    [_lock lock];

    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    [_lock unlock];
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
    [_lock lock];

    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    static int count = 0;
    if (count < 10)
    {
        ++count;
        [self recursiveTask];
    }
    
    [_lock unlock];
}

@end
