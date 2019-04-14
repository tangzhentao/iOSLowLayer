//
//  MutexDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/13.
//  Copyright © 2019 itang. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>

@interface MutexDemo ()

@property (assign, nonatomic) pthread_mutex_t saleTicketLock; // 自旋锁
@property (assign, nonatomic) pthread_mutex_t accountLock; // 自旋锁

@end

@implementation MutexDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initLock:&_saleTicketLock];
        [self initLock:&_accountLock];
    }
    return self;
}

- (void)initLock:(pthread_mutex_t *)lock
{
    // 初始化互斥锁的属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);
    
    // 初始化互斥锁
    pthread_mutex_init(lock, &attr);
    
    // 销毁互斥锁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)saleTicket
{
    pthread_mutex_lock(&_saleTicketLock);
    
    [super saleTicket];
    
    pthread_mutex_unlock(&_saleTicketLock);
}

- (void)saveMoney
{
    pthread_mutex_lock(&_accountLock);
    
    [super saveMoney];
    
    pthread_mutex_unlock(&_accountLock);
}

- (void)drawMoney
{
    pthread_mutex_lock(&_accountLock);
    
    [super drawMoney];
    
    pthread_mutex_unlock(&_accountLock);
}

@end
