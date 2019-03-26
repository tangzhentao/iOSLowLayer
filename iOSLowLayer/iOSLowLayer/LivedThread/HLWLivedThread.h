//
//  HLWLivedThread.h
//  iOSLowLayer
//
//  Created by tang on 2019/3/25.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 有生命的线程，能自己控制线程的生命周期，而不是单次任务完成后就销毁。
 */

@interface HLWLivedThread : NSObject

@property (strong, nonatomic) NSString *name;

/*!
 初始化线程。
 初始化后，线程就已经开始运行，可以直接提交任务执行；
 */
- (instancetype)init;

/*!
 在线程中执行一个任务
 */
- (void)performBlock:(void (^)(void))taskBlock;


/*!
 结束线程
 */
- (void)end;

//- (void)executeBlock:(void (^)(void))taskBlock;
//- (void)submitBlock:(void (^)(void))taskBlock;

@end

NS_ASSUME_NONNULL_END
