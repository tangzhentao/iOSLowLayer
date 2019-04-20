//
//  SemaphoreDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/20.
//  Copyright © 2019 itang. All rights reserved.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()

@property (strong, nonatomic) dispatch_semaphore_t semaphore; // 信号量
@property (strong, nonatomic) dispatch_semaphore_t ticketSemaphore; // 卖票信号量
@property (strong, nonatomic) dispatch_semaphore_t accountSemaphore; // 账户信号量


@end

@implementation SemaphoreDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _semaphore = dispatch_semaphore_create(5);
        _ticketSemaphore = dispatch_semaphore_create(1);
        _accountSemaphore = dispatch_semaphore_create(1);

    }
    return self;
}

- (void)testSemaphore
{
    for (int i = 0; i < 10; i++)
    {
        [[[NSThread alloc] initWithTarget:self selector:@selector(doSomethingWithDuration:) object:@(i)] start];
    }
}

- (void)doSomethingWithDuration:(NSNumber *)duration
{
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    int i = duration.intValue;
    NSLog(@"%d: begin", i);
    sleep(4);
    NSLog(@"%d: end", i);
    dispatch_semaphore_signal(_semaphore);
}

- (void)saleTicket
{
    dispatch_semaphore_wait(_ticketSemaphore, DISPATCH_TIME_FOREVER);
    
    [super saleTicket];
    
    dispatch_semaphore_signal(_ticketSemaphore);
}

- (void)saveMoney
{
    dispatch_semaphore_wait(_accountSemaphore, DISPATCH_TIME_FOREVER);
    
    [super saveMoney];
    
    dispatch_semaphore_signal(_accountSemaphore);
}

- (void)drawMoney
{
    dispatch_semaphore_wait(_accountSemaphore, DISPATCH_TIME_FOREVER);
    
    [super drawMoney];
    
    dispatch_semaphore_signal(_accountSemaphore);
}

@end
