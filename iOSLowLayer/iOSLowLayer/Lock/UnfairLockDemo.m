//
//  UnfairLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/13.
//  Copyright © 2019 itang. All rights reserved.
//

#import "UnfairLockDemo.h"
#import <os/lock.h>

@interface UnfairLockDemo ()

@property (assign, nonatomic) os_unfair_lock saleTicketLock;
@property (assign, nonatomic) os_unfair_lock accountLock;

@end

@implementation UnfairLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _saleTicketLock = OS_UNFAIR_LOCK_INIT;
        _accountLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)saleTicket
{
    os_unfair_lock_lock(&_saleTicketLock);
    
    [super saleTicket];
    
    os_unfair_lock_unlock(&_saleTicketLock);
}

- (void)saveMoney
{
    os_unfair_lock_lock(&_accountLock);
    
    [super saveMoney];
    
    os_unfair_lock_unlock(&_accountLock);
}

- (void)drawMoney
{
    os_unfair_lock_lock(&_accountLock);
    
    [super drawMoney];
    
    os_unfair_lock_unlock(&_accountLock);
}


@end
