//
//  main.m
//  block_modify_auto_var
//
//  Created by itang on 2019/11/9.
//  Copyright © 2019 learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (assign, nonatomic) int age;

@end

@implementation Person

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        __block int i = 11;
        __block Person *p = [Person new];
        void (^codes) (void) = ^{
            i = 20;
            p = [Person new];
            NSLog(@"i: %d", i);
        };
        
        codes ();
    }
    return 0;
}
