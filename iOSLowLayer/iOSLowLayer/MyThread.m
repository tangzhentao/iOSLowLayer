//
//  MyThread.m
//  LearnRunLoop
//
//  Created by tang on 2019/1/20.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import "MyThread.h"

static long MyThreadNum = 0;

@interface MyThread ()

@property (assign, nonatomic)  long  number;

@end

@implementation MyThread

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        MyThreadNum++;
        _number = MyThreadNum;
    }
    return self;
}

- (NSString *)name
{
    NSString *name = [super name];
    return [NSString stringWithFormat:@"%@ %ld", name, _number];
}

- (void)dealloc
{
    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), self.name);
}

@end
