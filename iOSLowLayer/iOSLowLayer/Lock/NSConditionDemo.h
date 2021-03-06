//
//  NSConditionDemo.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/19.
//  Copyright © 2019 itang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 NSCondition是对pthread_mutex_t和pthread_cond_t的封装
 */
@interface NSConditionDemo : NSObject

- (void)addData;

- (void)removeData;

@end

NS_ASSUME_NONNULL_END
