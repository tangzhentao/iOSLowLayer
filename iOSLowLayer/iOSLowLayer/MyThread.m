//
//  MyThread.m
//  LearnRunLoop
//
//  Created by tang on 2019/1/20.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import "MyThread.h"

@interface MyThread ()

@end

@implementation MyThread

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"[%@ %@]: %@<%p>", [self class], NSStringFromSelector(_cmd), self.name, self);
}

@end
