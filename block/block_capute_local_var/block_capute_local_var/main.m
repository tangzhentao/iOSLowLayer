//
//  main.m
//  block_capute_local_var
//
//  Created by tang on 2019/11/5.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

/* **功能**
 演示block捕获变量的情况
 
 自动局部变量捕获器原本的类型，静态布局变量捕获其指针类型；
 */

/*
 ARC block的底层实现
 
 struct __main_block_impl_0 {
     struct __block_impl impl;
     struct __main_block_desc_0* Desc;
     int auto_i;
     int *static_i;
     NSObject *__strong object; // 强引用
     NSString *__strong hello; // 强引用
     NSString *__strong *world; // 强引用
     __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _auto_i, int *_static_i, NSObject *__strong _object, NSString *__strong _hello, NSString *__strong *_world, int flags=0) : auto_i(_auto_i), static_i(_static_i), object(_object), hello(_hello), world(_world) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
 };
 */

/*
 MRC block的底层实现
 struct __main_block_impl_0 {
     struct __block_impl impl;
     struct __main_block_desc_0* Desc;
     int auto_i;
     int *static_i;
     NSObject *object; // 弱引用
     NSString *hello; // 弱引用
     NSString **world; // 弱引用
     __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _auto_i, int *_static_i, NSObject *_object, NSString *_hello, NSString **_world, int flags=0) : auto_i(_auto_i), static_i(_static_i), object(_object), hello(_hello), world(_world) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
 };

 */

int global_i = 10;
static int static_global_i = 20;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int auto_i = 2; // 相当于 auto int auto_i = 2; 局部变量默认是auto的，意思是出了作用域会自动释放；
        static int  static_i = 3;
        NSObject *object = [NSObject new];
        NSString *hello = @"hello";
        static NSString *world = @"world";
        void (^print_i)(void) = ^{
            NSLog(@"auto_i: %d, static_i: %d", auto_i, static_i);
            NSLog(@"global_i: %d, static_global_i: %d", global_i, static_global_i);
            NSLog(@"object: %@", object);
            NSLog(@"%@ %@", hello, world);
        };
        
        auto_i = 4;
        static_i = 5;
        
        global_i = 11;
        static_global_i = 21;
        print_i(); // auto_i: 2, static_i: 5
                   // global_i: 11, static_global_i: 21
        
        NSLog(@"%@", [print_i class]);
    }
    return 0;
}
