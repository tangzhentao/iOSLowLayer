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

/* 转成C++代码后对应的结构体为 */
struct NSObject_IMPL1 {
    __unsafe_unretained Class isa; // 指针类型占8字节
};// 整个结构体占8字节

struct Person_IMPL1 {
    struct NSObject_IMPL1 NSObject_IVARS; // 占8字节
    int age; // 占4字节
};// 整个结构体占16字节：成员变量共占12字节，因为内存对齐，占16字节，空4字节

struct Student_IMPL1 {
    struct Person_IMPL1 Person_IVARS;// 占16字节(空余4字节)
    int ID; // 占4字节，使用空余的那4字节
};// 为整个结构体分配16字节

struct MiddleSchoolStudent_IMPL1 {
    struct Student_IMPL1 Student_IVARS;// 占16字节
    int weight;// 占4字节
    int _height;// 占4字节
};// 为整个结构体分配32字节，因为要字节对齐

// 字节对齐规则：默认整个结构体体所占字节数是成员变量中占内存最大的那个变量的整数倍。
// 字节对齐的规则可以修改

struct MyPoint {
    int x;
    int y;
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
        middleStudent->ID = 0x1234abcd;
        middleStudent->age = 22;
        middleStudent->weight = 116;
        middleStudent.height = 180;
        mallocSize = malloc_size((__bridge const void *)middleStudent);
        NSLog(@"为MiddleSchoolStudent对象分配内存的大小: %zu", mallocSize); // 32字节
        
        /* 测试内存分配 */
        void *address24 = calloc(1, 24);
//        void *address24 = malloc(24);
        size_t address24_size = malloc_size(address24);
        NSLog(@"address24_size: %zd", address24_size);// 32
        
        void *address1 = calloc(1, 1);
        size_t address1_size = malloc_size(address1);
        NSLog(@"address1_size: %zd", address1_size); // 16
        /*
         说明：
         默认规则下系统分配的内存都是16的倍数：16、32、48、64、80、96 ... (最大的一块内存是256?)
         */
        
        // 验证
        int MiddleSchoolStudent_IMPL1_size = sizeof(struct MiddleSchoolStudent_IMPL1);
        NSLog(@"MiddleSchoolStudent_IMPL1_size: %d", MiddleSchoolStudent_IMPL1_size); // 32
        
        /* 查看静态分配内存的情况 */
        char c1 = 'a';
        char c2 = 'b';
        char c3 = 'c';
        char c4 = 'd';
        NSLog(@"&c1: %p", &c1); // 0x7ffeefbff49b
        NSLog(@"&c2: %p", &c2); // 0x7ffeefbff49a
        NSLog(@"&c3: %p", &c3); // 0x7ffeefbff499
        NSLog(@"&c4: %p", &c4); // 0x7ffeefbff498
        
        int i1 = 1;
        int i2 = 2;
        int i3 = 3;
        int i4 = 5;
        NSLog(@"&i1: %p", &i1); // 0x7ffeefbff494
        NSLog(@"&i2: %p", &i2); // 0x7ffeefbff490
        NSLog(@"&i3: %p", &i3); // 0x7ffeefbff48c
        NSLog(@"&i4: %p", &i4); // 0x7ffeefbff488

        struct MyPoint p1 = {1, 2};
        struct MyPoint p2 = {3, 4};
        struct MyPoint p3 = {4, 6};
        
        NSLog(@"&p1: %p", &p1); // 0x7ffeefbff480
        NSLog(@"&p2: %p", &p2); // 0x7ffeefbff478
        NSLog(@"&p3: %p", &p3); // 0x7ffeefbff470

        int MyPoint_size = sizeof(struct MyPoint);
        NSLog(@"MyPoint_size: %d", MyPoint_size); // 32
        /*
         结论
         为p1、p2、p3分别分配了8字节
         静态分配时没有最少16字节这个规则，动态分配时有
         */
        
        NSLog(@"hello world");

    }
    return 0;
}

/* 转成C++代码后对应的结构体为 */
struct NSObject_IMPL {
    __unsafe_unretained Class isa; // 指针类型占8字节
};// 整个结构体占8字节

struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS; // 占8字节
    int age; // 占4字节
};// 整个结构体占16字节：成员变量共占12字节，因为内存对齐，占16字节，空4字节

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
