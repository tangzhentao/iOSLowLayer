//
//  main.m
//  NSObjectSize
//
//  Created by tang on 2019/10/12.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h> // class_getInstanceSize
#import <malloc/malloc.h> // malloc_size

/// Person
@interface Person : NSObject
{
    @public
    int age;
}

@end

@implementation Person

@end

/// Student
@interface Student : Person
{
    @public
    int ID;
}

@end

@implementation Student
@end

/// MiddleSchoolStudent
@interface MiddleSchoolStudent : Student
{
    @public
    int weight;
}

@property (assign, readwrite, nonatomic) int height;

- (void)greet;

@end

@implementation MiddleSchoolStudent

- (void)greet {
    NSLog(@"hello, everybody.");
}

@end

/// 和类Student相同内存布局的结构体
struct Student_t
{
    Class isa;
    int ID;
    int age;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /* NSObject对象成员变量占用内存大小和系统为NSObject对象分配的内存大小 */
        size_t instanceSize = class_getInstanceSize([NSObject class]);
        NSLog(@"NSObject对象的大小: %zu", instanceSize); // 8字节
        
        NSObject *object = [[NSObject alloc] init];
        size_t mallocSize = malloc_size((__bridge const void *)object);
        NSLog(@"为NSObject对象分配内存的大小: %zu", mallocSize); // 16字节
        
        /* Person对象成员变量占用内存大小和系统为Person对象分配的内存大小 */
        instanceSize = class_getInstanceSize([Person class]);
        NSLog(@"Person对象的大小: %zu", instanceSize); // 16字节
        
        Person *person = [[Person alloc] init];
        mallocSize = malloc_size((__bridge const void *)person);
        NSLog(@"为Person对象分配内存的大小: %zu", mallocSize); // 16字节
        
        /* Student对象成员变量占用内存大小和系统为Student对象分配的内存大小 */
        instanceSize = class_getInstanceSize([Student class]);
        NSLog(@"Student对象的大小: %zu", instanceSize); // 16字节
        
        Student *student = [[Student alloc] init];
        mallocSize = malloc_size((__bridge const void *)student);
        NSLog(@"为Student对象分配内存的大小: %zu", mallocSize); // 16字节
        
        /* MiddleSchoolStudent对象成员变量占用内存大小和系统为MiddleSchoolStudent对象分配的内存大小 */
        instanceSize = class_getInstanceSize([MiddleSchoolStudent class]);
        NSLog(@"MiddleSchoolStudent对象的大小: %zu", instanceSize); // 24字节
        
        MiddleSchoolStudent *middleStudent = [[MiddleSchoolStudent alloc] init];
        mallocSize = malloc_size((__bridge const void *)middleStudent);
        NSLog(@"为MiddleSchoolStudent对象分配内存的大小: %zu", mallocSize); // 32字节
    }
    return 0;
}

/* 转成C++代码后对应的结构体为 */
struct NSObject_IMPL {
    __unsafe_unretained Class isa; // 指针类型占8字节
};// 为整个结构体分配16字节(因为框架要求至少分配16字节)

struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS; // 结构体占16字节(空8字节)
    int age; // 占4字节，使用空余8字节中的4字节
};// 为整个结构体分配16字节(空余4字节)

struct Student_IMPL {
    struct Person_IMPL Person_IVARS;// 占16字节(空余4字节)
    int ID; // 占4字节，使用空余的那4字节
};// 为整个结构体分配16字节

struct MiddleSchoolStudent_IMPL {
    struct Student_IMPL Student_IVARS;// 占16字节
    int weight;// 占4字节
    int _height;// 占4字节
};// 为整个结构体分配32字节，因为要字节对齐

// 字节对齐规则：默认整个结构体体所占字节数是成员变量中占内存最大的那个变量的整数倍。
// 字节对齐的规则可以修改
