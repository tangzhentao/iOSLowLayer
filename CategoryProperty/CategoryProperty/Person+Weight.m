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

#pragma mark - 2、指向自己的指针为key

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

#pragma mark - 3、以一个变量的地址为key
/*
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
*/

#pragma mark - 4、以C字符串为key
// 优点：简洁、明了，不用额外定义变量；
// 缺点：有出错的风险，因为需要set和get方法中的字符串保持一致；
// 有人通过把字符串定义为宏来解决字 "符串不一致的缺点"，我认为这样也不好，
// 因为这样做一来丧失了简洁的优点，二来定义的宏可能和其他宏重名；
/*
- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, "weight", @(weight), OBJC_ASSOCIATION_ASSIGN);
}
- (int)weight {
    return [objc_getAssociatedObject(self, "weight") intValue];
}

- (void)setHeight:(int)height {
    objc_setAssociatedObject(self, "height", @(height), OBJC_ASSOCIATION_ASSIGN);
}
- (int)height {
    return [objc_getAssociatedObject(self, "height") intValue];
}
*/
#pragma mark - 5、属性的get方法为key
// 最佳方案：简洁、明了，也避免了像字符串那样的不一致的风险；
- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_ASSIGN);
}
- (int)weight {
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

- (void)setHeight:(int)height {
    objc_setAssociatedObject(self, @selector(height), @(height), OBJC_ASSOCIATION_ASSIGN);
}
- (int)height {
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

- (void)setLover:(Person *)lover
{
    objc_setAssociatedObject(self, @selector(lover), lover, OBJC_ASSOCIATION_ASSIGN);
}

- (Person *)lover
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
