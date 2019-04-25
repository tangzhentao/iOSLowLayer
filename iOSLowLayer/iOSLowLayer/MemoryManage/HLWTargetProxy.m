//
//  HLWTimerProxy.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/23.
//  Copyright © 2019 itang. All rights reserved.
//

#import "HLWTargetProxy.h"

@interface HLWTargetProxy ()

@property (weak, nonatomic) id target;

@end

@implementation HLWTargetProxy

+ (instancetype)targetProxyWithTarget:(id)aTarget
{
    // 初始化NSProxy对象时不用也不要调用init方法，NSProxy没有init方法；
    HLWTargetProxy *proxy = [HLWTargetProxy alloc];
    proxy.target = aTarget;
    
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}


@end
