//
//  HLWTimerTarget.h
//  iOSLowLayer
//
//  Created by tang on 2019/4/23.
//  Copyright © 2019 itang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 NSTimer和target的中间对象
 弱引用realTarget
 */
@interface HLWTimerTarget : NSObject

+ (instancetype)timerTargetWithRealTarget:(id)realTarget;

@end

NS_ASSUME_NONNULL_END
