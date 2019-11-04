//
//  Person+Weight.h
//  CategoryProperty
//
//  Created by itang on 2019/11/3.
//  Copyright © 2019 learn. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Weight)

@property (assign, nonatomic) int weight;
@property (assign, nonatomic) int height;

@property (weak, nonatomic) Person *lover;

@end

NS_ASSUME_NONNULL_END
