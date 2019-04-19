//
//  NSConditionLockDemo.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import "NSConditionLockDemo.h"

#define NoData 0
#define HasData 1

@interface NSConditionLockDemo ()

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSConditionLock *conditionLock; // 条件锁


@end

@implementation NSConditionLockDemo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 初始化互斥锁属性
        _conditionLock = [[NSConditionLock alloc] initWithCondition:NoData];
        
        _dataArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

/*!
 
 */
- (void)addData
{
    // 加锁
    [_conditionLock lockWhenCondition:NoData];
    NSLog(@"%@ > 加锁", [NSThread currentThread].name);
    
    // 添加数据
    [_dataArray addObject:@"test data 1"];
    
    NSLog(@"%@ > 添加了一条数据", [NSThread currentThread].name);
    
    // 解锁
    [_conditionLock unlockWithCondition:HasData];
    
    NSLog(@"%@ > 解锁", [NSThread currentThread].name);
}

/*!
 
 */
- (void)removeData
{
    // 加锁
    [_conditionLock lockWhenCondition:HasData];
    NSLog(@"%@ > 加锁", [NSThread currentThread].name);

    // 添加数据
    [_dataArray removeLastObject];
    NSLog(@"%@ > 删除一条数据", [NSThread currentThread].name);
    
    // 解锁
    [_conditionLock unlockWithCondition:NoData];
    NSLog(@"%@ > 解锁", [NSThread currentThread].name);
}

@end
