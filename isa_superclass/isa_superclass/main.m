//
//  main.m
//  isa_superclass
//
//  Created by tang on 2019/10/18.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject

+ (void)class_print;
- (void)instance_print;

@end

@implementation Person

+ (void)class_print
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)instance_print
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

// 只能用类来调用类方法，不能使用对象。
void testCallClassMethod () {
    Person *p = [Person new];
    [Person class_print];
//    [p class_print]; // 报编译错误
}

void check_isa () {
    Person *p = [Person new];
//    class object_getClass(p);
//    object_getClass([Person class]);
//    p->isa;
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        testCallClassMethod ();
    }
    return 0;
}
