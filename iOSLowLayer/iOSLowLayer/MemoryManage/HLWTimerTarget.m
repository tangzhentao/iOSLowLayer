//
//  HLWTimerTarget.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/23.
//  Copyright © 2019 itang. All rights reserved.
//

#import "HLWTimerTarget.h"

@interface HLWTimerTarget ()

@property (weak, nonatomic) id realTarget;

@end

@implementation HLWTimerTarget

+ (instancetype)timerTargetWithRealTarget:(id)realTarget
{
    return [[self alloc] initWithRealTarget:realTarget];
}

- (instancetype)initWithRealTarget:(id)realTarget
{
    self = [super init];
    if (self) {
        _realTarget = realTarget;
    }
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return _realTarget;
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end
