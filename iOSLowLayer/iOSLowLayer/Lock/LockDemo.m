//
//  LockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/13.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockDemo.h"

@interface LockDemo ()

@property (assign, nonatomic) NSUInteger ticketSum;
@property (assign, nonatomic) NSInteger accountBalance;

@end

@implementation LockDemo

- (void)testSaleTickets
{
    _ticketSum = 20;
    dispatch_queue_t queue = dispatch_queue_create("ticket", DISPATCH_QUEUE_CONCURRENT);

    // 售票员A
    dispatch_async(queue, ^{
        
        [self nameCurrentThread:@"A"];
        
        for (int i = 0; i < 7; i++)
        {
            [self saleTicket];
        }
    });
    
    // 售票员B
    dispatch_async(queue, ^{
        [self nameCurrentThread:@"B"];
        
        for (int i = 0; i < 7; i++)
        {
            [self saleTicket];
        }
    });
    
    // 售票员C
    dispatch_async(queue, ^{
        [self nameCurrentThread:@"C"];
        
        for (int i = 0; i < 7; i++)
        {
            [self saleTicket];
        }
    });
}

- (void)saleTicket
{
    NSUInteger currentSum = self.ticketSum;
    NSLog(@"%@<%p>: current sum: %lu", [NSThread currentThread].name, [NSThread currentThread], currentSum);
    if (currentSum > 0)
    {
        self.ticketSum = currentSum - 1;
        NSLog(@"%@<%p>: sale a ticket, remain: %lu", [NSThread currentThread].name, [NSThread currentThread], self.ticketSum);
    } else
    {
        NSLog(@"%@<%p>: sell out", [NSThread currentThread].name, [NSThread currentThread]);
    }
    NSLog(@"");
}

- (void)testSaveDrawMoney
{
    _accountBalance = 600;
    dispatch_queue_t queue = dispatch_queue_create("account", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self nameCurrentThread:@"draw"];
        for (int i = 0; i < 5; i++)
        {
            [self drawMoney];
        }
    });
    
    dispatch_async(queue, ^{
        [self nameCurrentThread:@"save"];
        for (int i = 0; i < 8; i++)
        {
            [self saveMoney];
        }
    });
}

- (void)saveMoney
{
    NSLog(@"%@<%p>: current account balance: %lu", [NSThread currentThread].name, [NSThread currentThread], self.accountBalance);
    self.accountBalance += 100;
    NSLog(@"%@<%p>: after saving 100, account balance: %lu", [NSThread currentThread].name, [NSThread currentThread], self.accountBalance);
    NSLog(@"");
}

- (void)drawMoney
{
    NSLog(@"%@<%p>: current account balance: %lu", [NSThread currentThread].name, [NSThread currentThread], self.accountBalance);
    self.accountBalance -= 80;
    NSLog(@"%@<%p>: after drawing 80, account balance: %lu", [NSThread currentThread].name, [NSThread currentThread], self.accountBalance);
    NSLog(@"");
}

- (void)nameCurrentThread:(NSString *)name
{
    NSThread *thread = [NSThread currentThread];
    thread.name = name;
}

@end
