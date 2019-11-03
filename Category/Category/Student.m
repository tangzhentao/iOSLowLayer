//
//  Student.m
//  Category
//
//  Created by itang on 2019/11/2.
//  Copyright © 2019 Learn. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (void)load {
    NSLog(@"[%@ %@] primary class", [self class], NSStringFromSelector(_cmd));
}

//+ (void)initialize {
//    NSLog(@"[%@ %@] primary class", [self class], NSStringFromSelector(_cmd));
//}

@end
