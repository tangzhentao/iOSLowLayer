//
//  LearnItem.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/25.
//  Copyright © 2019 itang. All rights reserved.
//

#import "LearnItem.h"

@interface LearnItem ()

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) LearnItemType type;

@end

@implementation LearnItem

+ (instancetype)learnItemWithType:(int)type title:(NSString *)title
{
    return [[self alloc] initWithType:type title:title];
}

- (instancetype)initWithType:(int)type title:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
        _type = type;
    }
    return self;
}


@end
