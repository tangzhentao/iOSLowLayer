//
//  CheckLockTypeDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/15.
//  Copyright © 2019 itang. All rights reserved.
//

#import "CheckLockTypeDemo.h"
#import <libkern/OSAtomic.h>

@interface CheckLockTypeDemo ()

@property (assign, nonatomic) OSSpinLock saleTicketLock; // 自旋锁

@end

@implementation CheckLockTypeDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _saleTicketLock = OS_SPINLOCK_INIT;
        self.ticketSum = 20;

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
    OSSpinLockLock(&_saleTicketLock);
    NSLog(@"[%@ %@]: enter into lock.", [self class], NSStringFromSelector(_cmd));
    
    [super saleTicket];
    
    sleep(1000);
    OSSpinLockUnlock(&_saleTicketLock);
    NSLog(@"[%@ %@]: finish", [self class], NSStringFromSelector(_cmd));

}

@end
