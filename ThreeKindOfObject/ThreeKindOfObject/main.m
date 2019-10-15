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
        Class classObject6 = objc_getClass("NSObject");
        // 注意以下方法获取到的仍然是NSObject的类对象而不是元类对象
        Class classObject7 = [[NSObject class] class];
        
        // 验证内存中只有一个类对象
        NSLog(@"classObject1: %p", classObject1); // 0x7fff94542140
        NSLog(@"classObject2: %p", classObject2); // 0x7fff94542140
        NSLog(@"classObject3: %p", classObject3); // 0x7fff94542140
        NSLog(@"classObject4: %p", classObject4); // 0x7fff94542140
        NSLog(@"classObject5: %p", classObject5); // 0x7fff94542140
        NSLog(@"classObject6: %p", classObject6); // 0x7fff94542140
        NSLog(@"classObject7: %p", classObject7); // 0x7fff94542140

        /* 元类对象 */
        Class metaClassOjbect1 = object_getClass(classObject1);
        NSLog(@"metaClassOjbect1: %p", metaClassOjbect1); // 0x7fff945420f0
        
                
        // 查看Class变量是不是元类对象(MetaClass)
        BOOL isMetaClass = class_isMetaClass(metaClassOjbect1);
        NSLog(@"metaClassOjbect1 %@ meta class.", isMetaClass ? @"is" : @"is not"); // is
        isMetaClass = class_isMetaClass(classObject7);
        NSLog(@"classClass %@ meta class.", isMetaClass ? @"is" : @"is not"); // is not

    }
    return 0;
}
