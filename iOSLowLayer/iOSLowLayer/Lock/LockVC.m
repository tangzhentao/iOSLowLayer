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

@end
