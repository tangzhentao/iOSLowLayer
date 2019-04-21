//
//  NSLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

@property (strong, nonatomic) NSLock *saleTicketLock;
@property (strong, nonatomic) NSLock *accountLock;

@end

@implementation NSLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _saleTicketLock = [[NSLock alloc] init];
        _accountLock = [[NSLock alloc] init];
    }
    return self;
}

- (void)saleTicket
{
    [_saleTicketLock lock];
    
    [super saleTicket];
    
    [_saleTicketLock unlock];
}

- (void)saveMoney
{
    [_saleTicketLock lock];

    [super saveMoney];
    
    [_saleTicketLock unlock];
}

- (void)drawMoney
{
    [_saleTicketLock lock];
    
    [super drawMoney];

    [_saleTicketLock unlock];
}

@end

