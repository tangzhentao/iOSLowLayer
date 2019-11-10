//
//  main.m
//  block_forwarding
//
//  Created by itang on 2019/11/10.
//  Copyright © 2019 learn. All rights reserved.
//

#import <Foundation/Foundation.h>

struct __Block_byref_age_0 {
  void *__isa;
  struct __Block_byref_age_0 *__forwarding;
 int __flags;
 int __size;
 int age;
};

struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  struct __Block_byref_age_0 *age; // by ref
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        __block int age = 10;
        NSLog(@"age in stack: %p --> %d", &age, age); // 打印结果类似于：age in stack: 0x7ffeefbff4e8 --> 10
//        void (^block) (void) =
        ^{
            age = 20;
            NSLog(@"age in heap: %p --> %d", &age, age); // 打印结果类似于：age in heap: 0x100700048 --> 20
        };
        NSLog(@"age after block capturing: %p --> %d", &age, age);
//        struct __main_block_impl_0 *age_t = (__bridge struct __main_block_impl_0 *)(block);

//        block();
    }
    return 0;
}
