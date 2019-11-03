//
//  Student+Sport.m
//  Category
//
//  Created by itang on 2019/11/2.
//  Copyright © 2019 Learn. All rights reserved.
//

#import "Student+Sport.h"

#import <AppKit/AppKit.h>


@implementation Student (Sport)

+ (void)load {
    NSLog(@"[%@ %@] category Sport", [self class], NSStringFromSelector(_cmd));
}

//+ (void)initialize{
//    NSLog(@"[%@ %@] category Sport", [self class], NSStringFromSelector(_cmd));
//}

@end
