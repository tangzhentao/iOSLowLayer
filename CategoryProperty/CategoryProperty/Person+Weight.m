//
//  Person+Weight.m
//  CategoryProperty
//
//  Created by itang on 2019/11/3.
//  Copyright © 2019 learn. All rights reserved.
//

#import "Person+Weight.h"
#import "objc/runtime.h"

@implementation Person (Weight)

#pragma mark - 1、static const void *weight_key -- NULL

/*
 // 会导致两个属性的值相同
static const void *weightKey; // 没有赋值，值为NULL
static const void *heightKey; // 值也为NULL

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, weightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
}
- (int)weight {
    return [objc_getAssociatedObject(self, weightKey) intValue];
}

- (void)setHeight:(int)height {
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_ASSIGN);
}
- (int)height {
    return [objc_getAssociatedObject(self, heightKey) intValue];
}
*/

#pragma mark - 2、指向自己的指针

/*
static const void *weightKey = &weightKey;
static const void *heightKey = &heightKey;

 - (void)setWeight:(int)weight {
     objc_setAssociatedObject(self, weightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
 }
 
 - (int)weight {
     return [objc_getAssociatedObject(self, weightKey) intValue];
 }

- (void)setHeight:(int)height {
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_ASSIGN);
}
- (int)height {
    return [objc_getAssociatedObject(self, heightKey) intValue];
}
*/

#pragma mark - 2、以一个变量的地址为key

/**/
static char weightKey; // 使用char类型，是因为它占的内存少，只有1字节
static char heightKey;
- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, &weightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
}
- (int)weight {
    return [objc_getAssociatedObject(self, &weightKey) intValue];
}

- (void)setHeight:(int)height {
    objc_setAssociatedObject(self, &heightKey, @(height), OBJC_ASSOCIATION_ASSIGN);
}
- (int)height {
    return [objc_getAssociatedObject(self, &heightKey) intValue];
}

@end
