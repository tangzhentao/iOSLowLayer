//
//  HLWLivedThread.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/25.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import "HLWLivedThread.h"
#import "MyThread.h"

@interface HLWLivedThread ()

@property (weak, nonatomic) MyThread *innerThread;

@end

@implementation HLWLivedThread

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        MyThread *innerThread = [[MyThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        _innerThread = innerThread;
        [innerThread start];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"[%@ %@]: %@<%p>", [self class], NSStringFromSelector(_cmd), self.name, self);
}

- (void)performBlock:(void (^)(void))taskBlock
{
    if (self.innerThread && taskBlock) {
        [self performSelector:@selector(performBlockOnInnerThread:) onThread:self.innerThread withObject:taskBlock waitUntilDone:NO];
    }
}

- (void)performBlockOnInnerThread:(void (^)(void))taskBlock
{
    taskBlock();
}

- (void)end
{
    if (self.innerThread) {
        [self performSelector:@selector(endOnInnerThread) onThread:self.innerThread withObject:nil waitUntilDone:YES];
    }
}

- (void)endOnInnerThread
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.innerThread.name = name;
}

@end
