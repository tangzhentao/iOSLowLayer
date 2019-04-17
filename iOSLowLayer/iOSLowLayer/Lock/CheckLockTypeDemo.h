//
//  CheckLockTypeDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/15.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LockDemo.h"

/*!
 检查使用的锁是自旋锁还是互斥锁
 */

NS_ASSUME_NONNULL_BEGIN

@interface CheckLockTypeDemo : LockDemo

- (void)check;

@end

NS_ASSUME_NONNULL_END
