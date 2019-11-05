//
//  main.m
//  block_types
//
//  Created by itang on 2019/11/5.
//  Copyright © 2019 learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


void blockSuperclasses () {
    void (^block)(void) = ^{
        NSLog(@"I am a block.");
    };
    NSLog(@"%@", [block class]);
    NSLog(@"%@", [[block superclass] class]);
    NSLog(@"%@", [[[block superclass] superclass] class]);
    NSLog(@"%@", [[[[block superclass] superclass] superclass] class]);

    // __NSGlobalBlock__ --> __NSGlobalBlock --> NSBlock --> NSObject
}

void blockClasses () {
    void (^globalBlock)(void) = ^{
        NSLog(@"I am global block.");
    };
    
    int i = 2;
    void (^mallocBlock)(void) = ^{
        NSLog(@"I am malloc block: %d", i);
    };
    NSLog(@"global block: %@", [globalBlock class]);
    NSLog(@"malloc block: %@", [mallocBlock class]);
    NSLog(@"stack block: %@", [^{NSLog(@"stack block: %d", i);} class]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        blockSuperclasses();
        
        blockClasses ();


    }
    return 0;
}
