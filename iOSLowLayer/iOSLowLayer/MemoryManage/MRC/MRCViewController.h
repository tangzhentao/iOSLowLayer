//
//  MRCViewController.h
//  iOSLowLayer
//
//  Created by itang on 2019/5/1.
//  Copyright © 2019 itang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRCViewController : UIViewController

@property (retain, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;

@property (copy, nonatomic) NSMutableArray *dogs; // 将导致返回一个不可变数组NSArray，因copy返回的就是不可变对象



@end

NS_ASSUME_NONNULL_END
