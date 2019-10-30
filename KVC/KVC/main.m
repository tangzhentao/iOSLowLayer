//
//  main.m
//  KVC
//
//  Created by itang on 2019/10/29.
//  Copyright © 2019 itang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>

#pragma mark - Student
@interface Student : NSObject
{
    @public
    int _age;
}

@property (assign, nonatomic) int weight;

@end

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        _age = 0;
        _weight = 0;
    }
    return self;
}

//- (void)setName:(NSString *)name
//{
//    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), name);
//}

- (void)_setName:(NSString *)name
{
    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), name);
}

+ (BOOL)accessInstanceVariablesDirectly
{
    return YES;
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

#pragma mark - MainObject
@interface MainObject : NSObject

- (void)execute;

@end

@implementation MainObject

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"observe: %p, key: %@, change: %@", object, keyPath, change);
}

- (void)execute {
    
}

@end

void printMethodsOfClass(Class cls)
{
    // 获取方法列表
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        // 获取方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        NSLog(@"%@", methodName);
    }
    
    // C函数中以名字中有copy、create、new的函数返回的内存需要手动释放
    free(methodList);
}

#pragma mark - main

void enableKVO () {
    Student *student = [Student new];
    MainObject *main = [MainObject new];
    
    NSString *weightKey = @"weight";
    NSString *ageKey = @"age";
    
    [student addObserver:main forKeyPath:weightKey options:NSKeyValueObservingOptionNew context:nil];
    [student addObserver:main forKeyPath:ageKey options:NSKeyValueObservingOptionNew context:nil];
    
//    printMethodsOfClass(object_getClass(student));
    
    [student setValue:@1 forKey:weightKey];
    
    // 能触发kvo
    [student setValue:@2 forKey:ageKey];
    
    // 能触发kvo
    [student willChangeValueForKey:ageKey];
    student->_age = 3;
    [student didChangeValueForKey:ageKey];
}

void kvc ()
{
    Student *student = [Student new];
    [student setValue:@"jobs" forKey:@"name"];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        enableKVO ();

        NSLog(@"");
        NSLog(@"****** KVC ******");
        kvc ();
    }
    return 0;
}
