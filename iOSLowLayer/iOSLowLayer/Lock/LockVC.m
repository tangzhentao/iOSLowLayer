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

@interface LockVC ()

@property (strong, nonatomic) CheckLockTypeDemo *checkTypeDemo;

@property (strong, nonatomic) ConditionMutexLockDemo *conditionMutexLockDemo;
@property (strong, nonatomic) HLWLivedThread *addThread;
@property (strong, nonatomic) HLWLivedThread *removeThreadA;
@property (strong, nonatomic) HLWLivedThread *removeThreadB;

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

- (IBAction)testLockTicke:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}

- (IBAction)testLockMoney:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}




@end
