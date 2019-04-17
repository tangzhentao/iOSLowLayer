//
//  LockDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/13.
//  Copyright © 2019 itang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LockDemo : NSObject

@property (assign, nonatomic) NSUInteger ticketSum;


- (void)testSaleTickets;
- (void)saleTicket;

- (void)testSaveDrawMoney;
- (void)saveMoney;
- (void)drawMoney;

@end

NS_ASSUME_NONNULL_END
