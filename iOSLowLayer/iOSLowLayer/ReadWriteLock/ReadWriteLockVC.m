//
//  ReadWriteLockVC.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/22.
//  Copyright © 2019 itang. All rights reserved.
//

#import "ReadWriteLockVC.h"
#import <pthread.h>

@interface ReadWriteLockVC ()

@property (assign, nonatomic) pthread_rwlock_t rwLock;
@property (strong, nonatomic) dispatch_queue_t rwQueue;


@end

@implementation ReadWriteLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pthread_rwlock_init(&_rwLock, NULL);
    
    // 必须使用自己创建的并发队列
    _rwQueue = dispatch_queue_create("rw queue", DISPATCH_QUEUE_CONCURRENT);
}

#pragma mark - actions
- (IBAction)crossPlatformRWLock:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    /*
     多读单写：可以多个线程进行读操作，只能一个线程进行写操作；
     线程等待的时候是睡眠等待；
     */
    for (int i = 1; i < 11; i++)
    {
        if (i % 3 == 0)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSThread *currentThread = [NSThread currentThread];
                currentThread.name = [NSString stringWithFormat:@"%p", currentThread];
                [self writeWithCount_rwlock:i];
            });
        } else
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSThread *currentThread = [NSThread currentThread];
                currentThread.name = [NSString stringWithFormat:@"%p", currentThread];
                [self readWithCount_rwlock:i];
            });
        }
    }
}

- (IBAction)barrier:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    /*
     多读单写：可以多个线程进行读操作，只能一个线程进行写操作；
     线程等待的时候是睡眠等待；
     */
    for (int i = 1; i < 11; i++)
    {
        if (i % 3 == 0)
        {
            [self writeWithCount_barrier:i];
        } else
        {
            [self readWithCount_asyn:i];
        }
    }
}

#pragma mark - pthread_rwlock_t
- (void)readWithCount_rwlock:(int)count
{
    pthread_rwlock_rdlock(&_rwLock);
    
    [self readWithCount:count];
    
    pthread_rwlock_unlock(&_rwLock);
}

- (void)writeWithCount_rwlock:(int)count
{
    pthread_rwlock_wrlock(&_rwLock);
    
    [self writeWithCount:count];

    pthread_rwlock_unlock(&_rwLock);
}

#pragma mark - queue asyn barrier
- (void)readWithCount_asyn:(int)count
{
    dispatch_async(_rwQueue, ^{
        [self readWithCount:count];
    });
}

- (void)writeWithCount_barrier:(int)count
{
    dispatch_barrier_async(_rwQueue, ^{
        [self writeWithCount:count];
    });
}

#pragma mark - read/write
- (void)readWithCount:(int)count
{
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"%@ > read: %d,  begin ..", currentThread.name, count);
    
    sleep(1);
    NSLog(@"%@ > read: %d, continue .. ..", currentThread.name, count);
    
    sleep(count);
    NSLog(@"%@ > read: %d, end .", currentThread.name, count);
}

- (void)writeWithCount:(int)count
{
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"");
    NSLog(@"%@ > write: %d, begin ..", currentThread.name, count);
    sleep(2);
    NSLog(@"%@ > write: %d, continue .. ..", currentThread.name, count);
    
    sleep(2);
    NSLog(@"%@ > write: %d, end .", currentThread.name, count);
    NSLog(@"");
}

- (void)dealloc
{
    // 手动销毁
    pthread_rwlock_destroy(&_rwLock);
}

@end
