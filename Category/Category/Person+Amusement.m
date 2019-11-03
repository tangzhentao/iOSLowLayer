//
//  Person+Amusement.m
//  Category
//
//  Created by itang on 2019/11/2.
//  Copyright © 2019 Learn. All rights reserved.
//

#import "Person+Amusement.h"

@implementation Person (Amusement)

+ (void)load {
    NSLog(@"[%@ %@] category Amusement", [self class], NSStringFromSelector(_cmd));
}

+ (void)initialize{
    NSLog(@"[%@ %@] category Amusement", [self class], NSStringFromSelector(_cmd));
}

- (void)walk {
    NSLog(@"[%@ %@] category Amusement", [self class], NSStringFromSelector(_cmd));
}

- (void)sing {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}


@end
