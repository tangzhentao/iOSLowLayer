//
//  SpinLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/13.
//  Copyright © 2019 itang. All rights reserved.
//

#import "SpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface SpinLockDemo ()

@property (assign, nonatomic) OSSpinLock saleTicketLock; // 自旋锁
@property (assign, nonatomic) OSSpinLock accountLock; // 自旋锁

@end

@implementation SpinLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _saleTicketLock = OS_SPINLOCK_INIT;
        _accountLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)saleTicket
{
    OSSpinLockLock(&_saleTicketLock);
    
    [super saleTicket];
    
    OSSpinLockUnlock(&_saleTicketLock);
}

- (void)saveMoney
{
    OSSpinLockLock(&_accountLock);
    
    [super saveMoney];
    
    OSSpinLockUnlock(&_accountLock);
}

- (void)drawMoney
{
    OSSpinLockLock(&_accountLock);
    
    [super drawMoney];
    
    OSSpinLockUnlock(&_accountLock);
}

@end
