//
//  Person+Person_Sport.m
//  Category
//
//  Created by itang on 2019/11/2.
//  Copyright © 2019 Learn. All rights reserved.
//

#import "Person+Sport.h"

#import <AppKit/AppKit.h>


@implementation Person (Sport)

+ (void)load {
    NSLog(@"[%@ %@] category Sport", [self class], NSStringFromSelector(_cmd));
}

+ (void)initialize{
    if (self == [Person self]) {
        NSLog(@"Person(Sport) - %@", NSStringFromSelector(_cmd));
    }
}

- (void)breathe {
    NSLog(@"[%@ %@] category Sport", [self class], NSStringFromSelector(_cmd));
}

- (void)walk {
    NSLog(@"[%@ %@] category Sport", [self class], NSStringFromSelector(_cmd));
}

- (void)run {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end
