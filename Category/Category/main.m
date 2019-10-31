//
//  main.m
//  Category
//
//  Created by tang on 2019/10/31.
//  Copyright © 2019 Learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void)breathe;

@end

@implementation Person

- (void)breathe {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

@interface Person(Motion)

- (void)walk;
- (void)run;

@end

@implementation Person(Motion)

- (void)walk {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)run {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

@interface Person(Amusement)

- (void)sing;

@end

@implementation Person(Amusement)

- (void)sing {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *person = [Person new];
        [person breathe];
        [person walk];
        [person walk];
        [person sing];

    }
    return 0;
}
