//
//  main.m
//  block_capute_instance_self
//
//  Created by tang on 2019/11/5.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (assign, nonatomic) int age;
- (void)testBlockCaptureSelf;
- (void)testBlockCaptureSelfByInstanceVar;
@end

@implementation Person

- (void)testBlockCaptureSelf {
    // self 其实是通过隐式参数传入给方法的，函数的参数是局部变量，所以block会捕获self
    void (^printSelf) (void) = ^ {
        NSLog(@"%@", self);
    };
    
    printSelf ();
}

- (void)testBlockCaptureSelfByInstanceVar {
    void (^printAge) (void) = ^ {
        NSLog(@"%d", _age); // _age其实是通过self->_age访问的，所以会捕获self
    };
    
    printAge ();
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
    }
    return 0;
}
