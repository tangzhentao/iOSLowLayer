//
//  main.m
//  block
//
//  Created by tang on 2019/11/5.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int z = 10;
        void (^block)(int, int) = ^(int x, int y){
            NSLog(@"This is a block: %d, %d, %d", x, y, z);
        };
        block(8, 9);
    }
    return 0;
}
