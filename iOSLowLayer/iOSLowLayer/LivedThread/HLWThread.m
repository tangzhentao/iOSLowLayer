//
//  HLWThread.m
//  LearnRunLoop
//
//  Created by tang on 2019/1/20.
//  Copyright © 2019 itang. All rights reserved.
//

#import "HLWThread.h"

@implementation HLWThread

- (void)dealloc
{
    NSLog(@"[%@ %@]: %@<%p>", [self class], NSStringFromSelector(_cmd), self.name, self);
}

@end
