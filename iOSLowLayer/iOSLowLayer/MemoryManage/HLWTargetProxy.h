//
//  HLWTimerProxy.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/23.
//  Copyright © 2019 itang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 NSTimer的target的代理
 弱引用aTarget
 */

@interface HLWTargetProxy : NSProxy

+ (instancetype)targetProxyWithTarget:(id)aTarget;

@end

NS_ASSUME_NONNULL_END
