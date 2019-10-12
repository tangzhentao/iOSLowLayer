//
//  main.m
//  NSObjectSize
//
//  Created by tang on 2019/10/12.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h> // class_getInstanceSize
#import <malloc/malloc.h> // malloc_size

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 对象的成员变量占用的大小是8字节
        size_t size = class_getInstanceSize([NSObject class]);
        NSLog(@"size = %zu", size);
        
        // 为对象分配的内存是16字节
        NSObject *object = [[NSObject alloc] init];
        size_t mallocSize = malloc_size((__bridge const void *)object);
        NSLog(@"mallocSize = %zu", mallocSize);

        
    }
    return 0;
}
