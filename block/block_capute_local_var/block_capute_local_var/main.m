//
//  main.m
//  block_capute_local_var
//
//  Created by tang on 2019/11/5.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

int global_i = 10;
static int static_global_i = 20;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int auto_i = 2; // 相当于 auto int auto_i = 2; 局部变量默认是auto的，意思是出了作用域会自动释放；
        static int  static_i = 3;
        void (^print_i)(void) = ^{
            NSLog(@"auto_i: %d, static_i: %d", auto_i, static_i);
            NSLog(@"global_i: %d, static_global_i: %d", global_i, static_global_i);

        };
        
        auto_i = 4;
        static_i = 5;
        
        global_i = 11;
        static_global_i = 21;
        print_i(); // auto_i: 2, static_i: 5
                   // global_i: 11, static_global_i: 21
    }
    return 0;
}
