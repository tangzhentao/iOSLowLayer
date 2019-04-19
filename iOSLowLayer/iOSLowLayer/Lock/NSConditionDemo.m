//
//  NSConditionDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo ()

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSCondition *conditionLock; // 条件锁


@end

@implementation NSConditionDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 初始化互斥锁属性
        _conditionLock = [[NSCondition alloc] init];;
        
        _dataArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

/*!
 先上锁再添加数据，之后发信号，最后解锁
 */
- (void)addData
{
    // 加锁
    [_conditionLock lock];
    NSLog(@"%@ > 加锁", [NSThread currentThread].name);
    
    // 添加数据
    [_dataArray addObject:@"test data 1"];
    [_dataArray addObject:@"test data 2"];

    NSLog(@"%@ > 添加了两条数据", [NSThread currentThread].name);
    
    // 单发信号：疏通(unblock)一个等待条件_condition的线程
//    [_conditionLock signal];
//    NSLog(@"%@ > 单发了信号", [NSThread currentThread].name);
    
    // 广播信号：疏通所有等待条件_condition的线程
        [_conditionLock broadcast];
        NSLog(@"%@ > 广播了信号", [NSThread currentThread].name);
    
    // 解锁
    [_conditionLock unlock];

    NSLog(@"%@ > 解锁", [NSThread currentThread].name);
    
}

/*!
 有数据再删除，没数据时等待，直到有数据可删，有数据了立马删除一条；
 */
- (void)removeData
{
    // 加锁
    [_conditionLock lock];

    if (0 == _dataArray.count)
    {
        // 解锁并睡眠，收到条件发来的信号时唤醒并加锁
        NSLog(@"%@ > 睡觉", [NSThread currentThread].name);
        [_conditionLock wait];
        NSLog(@"%@ > 醒了", [NSThread currentThread].name);
    }
    // 添加数据
    [_dataArray removeLastObject];
    NSLog(@"%@ > 删除一条数据", [NSThread currentThread].name);
    
    // 解锁
    [_conditionLock unlock];

}

@end
