//
//  LearnItem.h
//  iOSLowLayer
//
//  Created by tang on 2019/3/25.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, LearnItemType)
{
    LearnItemTypeRunStopRunLoop,
    LearnItemTypeLivedThread,
};

NS_ASSUME_NONNULL_BEGIN

@interface LearnItem : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (assign, nonatomic, readonly) LearnItemType type;

+ (instancetype)learnItemWithType:(int)type title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
