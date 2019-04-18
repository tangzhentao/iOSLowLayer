//
//  ConditionMutexLockDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/18.
//  Copyright © 2019 itang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 使用条件的互斥锁
 */

@interface ConditionMutexLockDemo : NSObject

- (void)addData;

- (void)removeData;

@end

NS_ASSUME_NONNULL_END
