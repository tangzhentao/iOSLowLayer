//
//  main.m
//  block_copy
//
//  Created by tang on 2019/11/6.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void (^) (void))generateBlock;

@end

@implementation Person

// OC方法实现返回block
- (void (^) (void))generateBlock
{
    return ^{
        NSLog(@"hello world.");
    };
}

@end

// C函数实现返回block
void (^generateBlock ()) ()
{
    return ^{
        NSLog(@"hello world.");
    };
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Person *person = [Person new];
        [person generateBlock]();
    }
    return 0;
}
