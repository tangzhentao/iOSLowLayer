//
//  main.m
//  CategoryProperty
//
//  Created by itang on 2019/11/3.
//  Copyright © 2019 learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person+Weight.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *p1 = [Person new];
        p1.weight = 10;
        p1.height = 16;
        
        NSLog(@"p1 weight: %d, height: %d", p1.weight, p1.height);
        
        Person *p2 = [Person new];
        p2.weight = 20;
        p2.height = 26;

        NSLog(@"p2 weight: %d, height: %d", p2.weight, p2.height);
        
        {
            Person *mm = [Person new];
            p2.lover = mm;
        }
        
        /*
         将会发生运行时错误：EXC_BAD_ACCESS
         因为p2.lover指向的内存已经被释放，且p2.lover指针没有被置空，因为OBJC_ASSOCIATION_ASSIGN不等同于weak
         */
//        NSLog(@"p2's lover: %@", p2.lover); //
    }
    return 0;
}
