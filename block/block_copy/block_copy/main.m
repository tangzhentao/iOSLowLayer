//
//  main.m
//  block_copy
//
//  Created by tang on 2019/11/6.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (assign, nonatomic) int age;

//- (void (^) (void))generateBlock;

@end

@implementation Person

// OC方法实现返回block
//- (void (^) (void))generateBlock
//{
//    return ^{
//        NSLog(@"hello world.");
//    };
//}

- (void)dealloc {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
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
        
        /*
         OC方法返回block
         
         Person *person = [Person new];
         [person generateBlock]();
         */
        
//        void (^block) (void);
//        {
//            Person *person = [Person new];
//            person.age = 10;
//
//            block = [^{
//                NSLog(@"age: %d", person.age);
//            } copy];
//
//            [person release];
//        }
//        NSLog(@"hello world");
//
//        block();
        
        
        void (^block) (void);
       
        Person *person = [Person new];
        person.age = 10;
        
        block = ^{
            NSLog(@"age: %d", person.age);
        };
    
    }
    return 0;
}
