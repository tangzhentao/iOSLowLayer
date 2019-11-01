//
//  main.m
//  Category
//
//  Created by tang on 2019/10/31.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

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

@interface Person : NSObject

- (void)breathe;

@end

@implementation Person

+ (void)initialize
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

+ (void)someClassMethod
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)breathe {
    NSLog(@"[%@ %@] base", [self class], NSStringFromSelector(_cmd));
}

@end

@interface Person(Motion)

- (void)walk;
- (void)run;

@end

@implementation Person(Motion)

+ (void)initialize
{
    NSLog(@"[%@ %@]: Motion", [self class], NSStringFromSelector(_cmd));
}

- (void)breathe {
    NSLog(@"[%@ %@] Motion", [self class], NSStringFromSelector(_cmd));
}

- (void)walk {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)run {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

@interface Person(Amusement)

- (void)sing;

@end

@implementation Person(Amusement)

- (void)sing {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)breathe {
    NSLog(@"[%@ %@] Amusement", [self class], NSStringFromSelector(_cmd));
}

@end


@interface Student : Person

@end

@implementation Student

//+ (void)initialize
//{
//    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
//}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        Person *person = [Person new];
//        [person breathe];
//        [person walk];
//        [person run];
//        [person sing];
        
        [Student new];

    }
    return 0;
}
