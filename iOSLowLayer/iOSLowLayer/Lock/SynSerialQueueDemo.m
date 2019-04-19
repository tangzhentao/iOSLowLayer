//
//  SynSerialQueueDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "SynSerialQueueDemo.h"

@interface SynSerialQueueDemo ()

@property (strong, nonatomic) dispatch_queue_t saleTicketQueue; // 自旋锁
@property (strong, nonatomic) dispatch_queue_t accountQueue; // 自旋锁

@end

@implementation SynSerialQueueDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _saleTicketQueue = dispatch_queue_create("ticket", DISPATCH_QUEUE_SERIAL);
        _accountQueue = dispatch_queue_create("ticket", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)saleTicket
{
    dispatch_sync(_saleTicketQueue, ^{
        [super saleTicket];
    });
}

- (void)saveMoney
{
    dispatch_sync(_accountQueue, ^{
        [super saveMoney];
    });
}

- (void)drawMoney
{
    dispatch_sync(_accountQueue, ^{
        [super drawMoney];
    });
}

@end
