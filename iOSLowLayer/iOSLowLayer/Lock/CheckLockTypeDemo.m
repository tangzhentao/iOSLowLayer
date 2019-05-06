//
//  CheckLockTypeDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/15.
//  Copyright © 2019 itang. All rights reserved.
//

#import "CheckLockTypeDemo.h"
#import <libkern/OSAtomic.h>
#import <pthread.h>
#import <os/lock.h>

@interface CheckLockTypeDemo ()

@property (assign, nonatomic) OSSpinLock saleTicketLock; // 自旋锁
@property (assign, nonatomic) pthread_mutex_t mutexLock; // 互斥锁
@property (assign, nonatomic) os_unfair_lock unfairLock; // 不公锁

@end

@implementation CheckLockTypeDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _saleTicketLock = OS_SPINLOCK_INIT;
        self.ticketSum = 20;
        
        // 初始化互斥锁
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
        pthread_mutex_init(&_mutexLock, &attr);
        
        // 初始化不公锁
        _unfairLock = OS_UNFAIR_LOCK_INIT;

        
    }
    return self;
}

- (void)check
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:self] start];
}

- (void)saleTicket
{
    NSLog(@"[%@ %@]: out of lock.", [self class], NSStringFromSelector(_cmd));
//    OSSpinLockLock(&_saleTicketLock);
//    pthread_mutex_lock(&_mutexLock);
    os_unfair_lock_lock(&_unfairLock);
    NSLog(@"[%@ %@]: enter into lock.", [self class], NSStringFromSelector(_cmd));
    
    [super saleTicket];
    
    sleep(1000);
//    OSSpinLockUnlock(&_saleTicketLock);
//    pthread_mutex_unlock(&_mutexLock);
    os_unfair_lock_unlock(&_unfairLock);


    NSLog(@"[%@ %@]: finish", [self class], NSStringFromSelector(_cmd));

}

@end
