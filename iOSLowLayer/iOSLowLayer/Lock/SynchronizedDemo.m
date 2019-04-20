//
//  SynchronizedDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/20.
//  Copyright © 2019 itang. All rights reserved.
//

#import "SynchronizedDemo.h"

@implementation SynchronizedDemo

- (void)testSynchronized
{
    // 这是个递归锁
    static int i = 0;
    @synchronized (self)
    {
        NSLog(@"%s: %d", __func__, i);
        i++;
        
        if (i < 10) {
            [self testSynchronized];
        }
    }
}

- (void)saleTicket
{
    static NSObject *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc] init];
    });
    
    @synchronized (lock) {
        [super saleTicket];
    }
}

- (void)saveMoney
{
    @synchronized (self) {
        [super saveMoney];
    }
}

- (void)drawMoney
{
    @synchronized (self) {
        [super drawMoney];
    }
}




@end
