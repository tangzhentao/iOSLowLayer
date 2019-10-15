//
//  main.m
//  ThreeKindOfObject
//
//  Created by tang on 2019/10/15.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h> // object_getClass

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        /* 实例对象 */
        NSObject *object1 = [[NSObject alloc] init];
        NSObject *object2 = [[NSObject alloc] init];

        /* 类对象 */
        Class classObject1 = [object1 class];
        Class classObject2 = [object2 class];
        Class classObject3 = [NSObject class];
        Class classObject4 = object_getClass(object1);
        Class classObject5 = object_getClass(object2);
        
        // 验证内存中只有一个类对象
        NSLog(@"classObject1: %p", classObject1); // 0x7fffad572140
        NSLog(@"classObject2: %p", classObject2); // 0x7fffad572140
        NSLog(@"classObject3: %p", classObject3); // 0x7fffad572140
        NSLog(@"classObject4: %p", classObject4); // 0x7fffad572140
        NSLog(@"classObject5: %p", classObject5); // 0x7fffad572140



    }
    return 0;
}
