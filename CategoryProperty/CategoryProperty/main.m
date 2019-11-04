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
    }
    return 0;
}
