//
//  main.m
//  Category
//
//  Created by tang on 2019/10/31.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Student.h"
#import "Person+Sport.h"

void printMethodsOfClass(Class cls)
{
    // 获取方法列表
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        // 获取方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        NSLog(@"%@", methodName);
    }
    
    // C函数中以名字中有copy、create、new的函数返回的内存需要手动释放
    free(methodList);
}

/*
 测试调用哪一个方法
 
 *结论*
 1、当主类和分类中有同名的方法时，会调用分类中的方法，不论主类和分类的编译顺序如何。
 2、当同一个主类的分类中有同名方法时，会调用编译顺序靠后的分类中的方法；
 
 *测试步骤*
 1、当主类和分类中有同名的方法时，通过调整编译顺序看看调用谁的方法；
 2、当通过一个主类有多个分类，且分类中有同名方法时，通过调整编译顺序，看看调用谁的方法。
 */
void testCallWhichMethod ()
{
    Person *person = [Person new];
    [person breathe];
    
    [person walk];
}

void testInitializeMethod () {
    Person *person = [Person new];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        testCallWhichMethod ();
        
        testInitializeMethod ();
        
        

    }
    return 0;
}
