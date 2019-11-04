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
static const void *weightKey; // 没有赋值，值为NULL

- (void)setWeight:(int)weight
{
    objc_setAssociatedObject(self, weightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
}

- (int)weight
{
    return [objc_getAssociatedObject(self, weightKey) intValue];
}
*/

#pragma mark - 2、指向自己的指针

/*
 static const void *weightKey = &weightKey;
 
 - (void)setWeight:(int)weight
 {
     objc_setAssociatedObject(self, weightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
 }
 
 - (int)weight
 {
     return [objc_getAssociatedObject(self, weightKey) intValue];
 }
*/
#pragma mark - 2、指向自己的指针

static char weightKey;

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, &weightKey, @(weight), OBJC_ASSOCIATION_ASSIGN);
}

- (int)weight {
    return [objc_getAssociatedObject(self, &weightKey) intValue];
}

@end
