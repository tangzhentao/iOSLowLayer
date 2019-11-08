//
//  main.m
//  block_copy
//
//  Created by tang on 2019/11/6.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (assign, nonatomic) int age;

- (void (^) (void))generateBlock;

@end

@implementation Person

// OC方法实现返回block
- (void (^) (void))generateBlock
{
    int i = 1;
    return ^{
        NSLog(@"hello world: %d", i);
    };
}

- (void)dealloc {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

// C函数实现返回block
void (^generateBlock ()) ()
{
    int i = 2;
    return ^{
        NSLog(@"hello world: %d", i);
    };
}

/* ***** 测试把栈block复制到堆上的情况 *****
 
 以下情况会把栈block复制到堆上：
 1、C函数或OC方法返回block
 2、把block赋值给__strong指针
 3、cocoa API 方法名包含UsingBlock的参数
 4、GCD方法的参数
 */
void testMoveStackBlockToHeap ()
{
    int i = 3;
    NSLog(@"block: %@", [^{NSLog(@"hello: %d", i);} class]);
    NSLog(@"block returned by C function: %@", [generateBlock() class]);
    NSLog(@"block returned by OC method: %@", [[[Person new] generateBlock] class]);
    
    void (^block) (void) = ^{
        NSLog(@"hello: %d", i);
    };
    NSLog(@"__strong block: %@", [block class]);
    
    NSArray *array = @[@"hello", @"world"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index: %lu, obj: %@", (unsigned long)idx, obj);
    }];
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"hello: %d", i);
    });
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        /*
         OC方法返回block
         
         Person *person = [Person new];
         [person generateBlock]();
         */
        
//        void (^block) (void);
//        {
//            Person *person = [Person new];
//            person.age = 10;
//
//            block = [^{
//                NSLog(@"age: %d", person.age);
//            } copy];
//
//            [person release];
//        }
//        NSLog(@"hello world");
//
//        block();
        
        testMoveStackBlockToHeap ();
        
        
        void (^block) (void);
       
        Person *person = [Person new];
        person.age = 10;
        
        block = ^{
            NSLog(@"age: %d", person.age);
        };
    
    }
    return 0;
}
