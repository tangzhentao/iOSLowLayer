//
//  Person.m
//  Category
//
//  Created by itang on 2019/11/2.
//  Copyright © 2019 Learn. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)load {
    NSLog(@"[%@ %@] primary class", [self class], NSStringFromSelector(_cmd));
}

+ (void)initialize{
    if (self == [Person self]) {
        NSLog(@"[%@ %@] primary class", [self class], NSStringFromSelector(_cmd));
    }
}

+ (void)someClassMethod
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)breathe {
    NSLog(@"[%@ %@] primary class", [self class], NSStringFromSelector(_cmd));
}

@end
