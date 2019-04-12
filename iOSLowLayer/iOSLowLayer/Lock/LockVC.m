//
//  LockVC.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/12.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockVC.h"
#import <libkern/OSAtomic.h>

@interface LockVC ()

@property (assign, nonatomic) NSUInteger ticketSum;
@property (assign, nonatomic) NSInteger accountBalance;
@property (assign, nonatomic) OSSpinLock spinLock; // 自旋锁
@property (assign, nonatomic) OSSpinLock accountLock; // 自旋锁

@end

@implementation LockVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _spinLock = OS_SPINLOCK_INIT;
    _accountLock = OS_SPINLOCK_INIT;
}

- (IBAction)testSaleTickets:(id)sender
{
    _ticketSum = 20;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
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

- (IBAction)testSaveDrawMoney:(id)sender
{
    _accountBalance = 600;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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

#pragma mark - sale ticket
- (void)saleTicket
{
    
    OSSpinLockLock(&_spinLock);
    NSUInteger currentSum = self.ticketSum;
    NSLog(@"%@: current sum: %lu", [NSThread currentThread].name, currentSum);
    if (currentSum > 0)
    {
        self.ticketSum = currentSum - 1;
        NSLog(@"%@: sale a ticket, remain: %lu", [NSThread currentThread].name, self.ticketSum);
    } else
    {
        NSLog(@"%@: sell out", [NSThread currentThread].name);
    }
    NSLog(@"");
    OSSpinLockUnlock(&_spinLock);
}

#pragma mark - save/draw money
- (void)saveMoney
{
    OSSpinLockLock(&_accountLock);
    NSLog(@"%@: current account balance: %lu", [NSThread currentThread].name, self.accountBalance);
    self.accountBalance += 100;
    NSLog(@"%@: after saving 100, account balance: %lu", [NSThread currentThread].name, self.accountBalance);
    NSLog(@"");
    OSSpinLockUnlock(&_accountLock);
}

- (void)drawMoney
{
    OSSpinLockLock(&_accountLock);
    NSLog(@"%@: current account balance: %lu", [NSThread currentThread].name, self.accountBalance);
    self.accountBalance -= 80;
    NSLog(@"%@: after drawing 80, account balance: %lu", [NSThread currentThread].name, self.accountBalance);
    NSLog(@"");
    OSSpinLockUnlock(&_accountLock);

    
}

- (void)nameCurrentThread:(NSString *)name
{
    NSThread *thread = [NSThread currentThread];
    if (thread.name.length == 0) {
        thread.name = name;
    }
}

@end
