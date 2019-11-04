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
        
        NSLog(@"p1 weight: %d", p1.weight);
        
        Person *p2 = [Person new];
        p2.weight = 20;
        
        NSLog(@"p2 weight: %d", p2.weight);
    }
    return 0;
}
