//
//  Person.m
//  KVC
//
//  Created by itang on 2019/10/29.
//  Copyright © 2019 itang. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (BOOL)accessInstanceVariablesDirectly
{
    return NO;
}

- (void)test
{
//    [self accessInstanceVariablesDirectly];
    [[self class] accessInstanceVariablesDirectly];
}

@end
