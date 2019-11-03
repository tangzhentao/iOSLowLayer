//
//  Student+Amusement.m
//  Category
//
//  Created by itang on 2019/11/2.
//  Copyright © 2019 Learn. All rights reserved.
//

#import "Student+Amusement.h"

#import <AppKit/AppKit.h>


@implementation Student (Amusement)

+ (void)load {
    NSLog(@"[%@ %@] category Amusement", [self class], NSStringFromSelector(_cmd));
}

//+ (void)initialize{
//    NSLog(@"[%@ %@] category Amusement", [self class], NSStringFromSelector(_cmd));
//}

@end
