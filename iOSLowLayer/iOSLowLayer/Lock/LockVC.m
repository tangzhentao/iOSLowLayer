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

@interface LockVC ()


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

- (IBAction)testLockTicke:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}

- (IBAction)testLockMoney:(id)sender
{
    [[[UnfairLockDemo alloc] init] testSaveDrawMoney];
}



@end
