//
//  LockVC.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/12.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockVC.h"
#import "SpinLockDemo.h"
#import "UnfairLockDemo.h"
#import "MutexDemo.h"
#import "RecursiveMutexLockDemo.h"
#import "CheckLockTypeDemo.h"
#import "ConditionMutexLockDemo.h"
#import "HLWLivedThread.h"
#import "NSLockDemo.h"
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"

@interface LockVC ()

@property (strong, nonatomic) CheckLockTypeDemo *checkTypeDemo;

@property (strong, nonatomic) ConditionMutexLockDemo *conditionMutexLockDemo;
@property (strong, nonatomic) HLWLivedThread *addThread;
@property (strong, nonatomic) HLWLivedThread *removeThreadA;
@property (strong, nonatomic) HLWLivedThread *removeThreadB;

@property (strong, nonatomic) NSConditionDemo *conditionDemo;
@property (strong, nonatomic) NSConditionLockDemo *conditionLockDemo;

@end

@implementation LockVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - spin lock

- (IBAction)testSaleTickets:(id)sender
{
    [[[SpinLockDemo alloc] init] testSaleTickets];
}

- (IBAction)testSaveDrawMoney:(id)sender
{
    [[[SpinLockDemo alloc] init] testSaveDrawMoney];
}

#pragma mark - unfaire lock

- (IBAction)testUnfairLockTicket:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaleTickets];
}

- (IBAction)testUnfairLockMoney:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}

- (IBAction)testMutexLockTicke:(id)sender
{
    [[[MutexDemo alloc] init] testSaleTickets];
}

- (IBAction)testMutexLockMoney:(id)sender
{
    [[[MutexDemo alloc] init] testSaveDrawMoney];
}

- (IBAction)testMutexLockMainTask:(id)sender
{
    [[[RecursiveMutexLockDemo alloc] init] mainTask];
}

- (IBAction)testMutexLockRecursiveTask:(id)sender
{
    [[[RecursiveMutexLockDemo alloc] init] recursiveTask];
}

- (IBAction)checkLockType:(id)sender
{
    if (!_checkTypeDemo)
    {
        _checkTypeDemo = [[CheckLockTypeDemo alloc] init];
    }
    
    [_checkTypeDemo check];
    
}

- (IBAction)checkLockTypeAgain:(id)sender
{
    if (!_checkTypeDemo)
    {
        _checkTypeDemo = [[CheckLockTypeDemo alloc] init];
    }
    
    [_checkTypeDemo check];
    
}

#pragma mark - condition mutext lock
- (IBAction)add:(id)sender
{
    if (!_conditionMutexLockDemo)
    {
        _conditionMutexLockDemo = [[ConditionMutexLockDemo alloc] init];
    }
    
    if (!_addThread)
    {
        _addThread = [[HLWLivedThread alloc] init];
        _addThread.name = @"adder";
    }
    
    __weak typeof(self) weakSelf = self;
    [_addThread asynPerformBlock:^{
        [weakSelf.conditionMutexLockDemo addData];
    }];
    
}

- (IBAction)removeA:(id)sender
{
    if (!_conditionMutexLockDemo)
    {
        _conditionMutexLockDemo = [[ConditionMutexLockDemo alloc] init];
    }
    
    if (!_removeThreadA)
    {
        _removeThreadA = [[HLWLivedThread alloc] init];
        _removeThreadA.name = @"remover A";
    }
    
    __weak typeof(self) weakSelf = self;
    [_removeThreadA asynPerformBlock:^{
        [weakSelf.conditionMutexLockDemo removeData];
    }];
    
}

- (IBAction)removeB:(id)sender
{
    if (!_conditionMutexLockDemo)
    {
        _conditionMutexLockDemo = [[ConditionMutexLockDemo alloc] init];
    }
    
    if (!_removeThreadB)
    {
        _removeThreadB = [[HLWLivedThread alloc] init];
        _removeThreadB.name = @"remover B";
    }
    
    __weak typeof(self) weakSelf = self;
    [_removeThreadB asynPerformBlock:^{
        [weakSelf.conditionMutexLockDemo removeData];
    }];
    
}

#pragma mark - NSLock
- (IBAction)testNSLockTicke:(id)sender
{
    [[[NSLockDemo alloc] init] testSaleTickets];
}

- (IBAction)testNSLockMoney:(id)sender
{
    [[[NSLockDemo alloc] init] testSaveDrawMoney];
}


#pragma mark - NSRecursiveLock
- (IBAction)testMainTaskSubtask:(id)sender
{
    [[[NSRecursiveLockDemo alloc] init] mainTask];
}

- (IBAction)testRecursiveTask:(id)sender
{
    [[[NSRecursiveLockDemo alloc] init] recursiveTask];
}

#pragma mark - NSCondition
- (IBAction)add1:(id)sender
{
    if (!_conditionDemo)
    {
        _conditionDemo = [[NSConditionDemo alloc] init];
    }
    
    if (!_addThread)
    {
        _addThread = [[HLWLivedThread alloc] init];
        _addThread.name = @"adder";
    }
    
    __weak typeof(self) weakSelf = self;
    [_addThread asynPerformBlock:^{
        [weakSelf.conditionDemo addData];
    }];
}

- (IBAction)removeA1:(id)sender
{
    if (!_conditionDemo)
    {
        _conditionDemo = [[NSConditionDemo alloc] init];
    }
    
    if (!_removeThreadA)
    {
        _removeThreadA = [[HLWLivedThread alloc] init];
        _removeThreadA.name = @"remover A";
    }
    
    __weak typeof(self) weakSelf = self;
    [_removeThreadA asynPerformBlock:^{
        [weakSelf.conditionDemo removeData];
    }];
    
}

- (IBAction)removeB1:(id)sender
{
    if (!_conditionDemo)
    {
        _conditionDemo = [[NSConditionDemo alloc] init];
    }
    
    if (!_removeThreadB)
    {
        _removeThreadB = [[HLWLivedThread alloc] init];
        _removeThreadB.name = @"remover B";
    }
    
    __weak typeof(self) weakSelf = self;
    [_removeThreadB asynPerformBlock:^{
        [weakSelf.conditionDemo removeData];
    }];
    
}

#pragma mark - NSConditionLock
- (IBAction)add2:(id)sender
{
    if (!_conditionLockDemo)
    {
        _conditionLockDemo = [[NSConditionLockDemo alloc] init];
    }
    
    if (!_addThread)
    {
        _addThread = [[HLWLivedThread alloc] init];
        _addThread.name = @"adder";
    }
    
    __weak typeof(self) weakSelf = self;
    [_addThread asynPerformBlock:^{
        [weakSelf.conditionLockDemo addData];
    }];
    
}

- (IBAction)remove2A:(id)sender
{
    if (!_conditionLockDemo)
    {
        _conditionLockDemo = [[NSConditionLockDemo alloc] init];
    }
    
    if (!_removeThreadA)
    {
        _removeThreadA = [[HLWLivedThread alloc] init];
        _removeThreadA.name = @"remover A";
    }
    
    __weak typeof(self) weakSelf = self;
    [_removeThreadA asynPerformBlock:^{
        [weakSelf.conditionLockDemo removeData];
    }];
    
}

- (IBAction)remove2B:(id)sender
{
    if (!_conditionLockDemo)
    {
        _conditionLockDemo = [[NSConditionLockDemo alloc] init];
    }
    
    if (!_removeThreadB)
    {
        _removeThreadB = [[HLWLivedThread alloc] init];
        _removeThreadB.name = @"remover B";
    }
    
    __weak typeof(self) weakSelf = self;
    [_removeThreadB asynPerformBlock:^{
        [weakSelf.conditionLockDemo removeData];
    }];
    
}
#pragma mark - other
- (IBAction)testLockTicke:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}

- (IBAction)testLockMoney:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}




@end
