//
//  main.m
//  block_classes_details
//
//  Created by itang on 2019/11/5.
//  Copyright © 2019 learn. All rights reserved.
//

#import <Foundation/Foundation.h>

/*** 功能 **
 测试、演示block的三种类型
 
 **说明**
 把工程设置成mrc
 */

int a = 9;

void (^BadBlock) (void);

// 把栈block赋值给全局的block变量
void setLocalBlockToGlobalBlockVar ()
{
    int i = 2;
    BadBlock = ^{
        NSLog(@"local int i = %d", i);
    };
    
    BadBlock();
}

// 定义一个函数，返回值为一个block
void ( ^generateBlock () ) (void)
{
    return ^{NSLog(@"hello");};
}

// 和上面的函数等价
typedef void (^BlockType) (void);
BlockType generateBlock_ ()
{
    return ^{NSLog(@"hello");};
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 1、全局block
        void (^globalBlock) (void) = ^{
            NSLog(@"global block: %d", a);
        };
        NSLog(@"globalBlock: %@<%p>", [globalBlock class], globalBlock);
        
        // 复制全局block,得到的block的地址与原block一样
        void (^globalBlockCopy) (void) = [globalBlock copy];
        NSLog(@"globalBlockCopy: %@<%p>", [globalBlockCopy class], globalBlockCopy);
        
        // 2、栈block
        int i = 1;
        void (^stackBlock) (void) = ^{
            NSLog(@"stack block: %d", i);
        };
        NSLog(@"stackBlock: %@<%p>", [stackBlock class], stackBlock);
        
        // 3、堆block
        // 复制栈block,就可以得到的堆block
        void (^mallocBlock) (void) = [stackBlock copy];
        NSLog(@"mallocBlock: %@<%p>", [mallocBlock class], mallocBlock);
        // 复制堆block,得到的block的地址与原block一样
        void (^mallocBlockCopy) (void) = [mallocBlock copy];
        NSLog(@"mallocBlockCopy: %@<%p>", [mallocBlockCopy class], mallocBlockCopy);
        
        // mrc环境下，要手动管理内存，copy的变量需要手动释放
        [globalBlockCopy release];
        [mallocBlock release];
        [mallocBlockCopy release];
        
        // 演示栈block在作用域外执行的情况
        setLocalBlockToGlobalBlockVar(); // local int i = 2
        BadBlock (); // local int i = -272632680
        NSLog(@"will crash...");
        BadBlock (); // crash

    }
    return 0;
}
