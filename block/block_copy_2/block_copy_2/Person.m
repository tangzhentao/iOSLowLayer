//
//  Person.m
//  block_copy_2
//
//  Created by itang on 2019/11/9.
//  Copyright © 2019 learn. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end
