//
//  main.m
//  block_capture_weak_strong
//
//  Created by tang on 2019/11/8.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (assign, nonatomic) int age;

@end

@implementation Person

- (void)dealloc {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        void (^block) (void);
        {
            Person *person = [Person new];
            person.age = 10;
            
            /* 捕获__strong auto 变量
             struct __main_block_impl_0 {
             struct __block_impl impl;
             struct __main_block_desc_0* Desc;
             Person *__strong person; // 这里的__strong是关键
             __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, Person *__strong _person, int flags=0) : person(_person) {
             impl.isa = &_NSConcreteStackBlock;
             impl.Flags = flags;
             impl.FuncPtr = fp;
             Desc = desc;
             }
             };
             */
//            block  = ^{
//                NSLog(@"age: %d", person.age);
//            };
            
            __weak Person *weakPerson = person;
            
            /*
             对于__weak的编译命令如下： -fobjc-arc -fobjc-runtime=ios-8.0.0
             xcrun -sdk iphoneos clang -arch arm64 -fobjc-arc -fobjc-runtime=ios-8.0.0 mian.m
             */

            /* 捕获__strong auto 变量
             struct __main_block_impl_0 {
             struct __block_impl impl;
             struct __main_block_desc_0* Desc;
             Person *__weak weakPerson; // 这里的__weak是关键
             __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, Person *__weak _weakPerson, int flags=0) : weakPerson(_weakPerson) {
             impl.isa = &_NSConcreteStackBlock;
             impl.Flags = flags;
             impl.FuncPtr = fp;
             Desc = desc;
             }
             };
             */
            block  = ^{
                NSLog(@"age: %d", weakPerson.age);
            };
        }
        
        NSLog(@"Hello!");
        block ();
    }
    NSLog(@"World!");
    return 0;
}
