//
//  main.m
//  isa_superclass
//
//  Created by tang on 2019/10/18.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/* NSObject的分类 */

#pragma mark - NSObject(superclass)
@interface NSObject (superclass)

/*
 验证根类的meta-class对象的superclass指向根类class对象
 */
- (void)instanceMethod;

@end

@implementation NSObject (superclass)

- (void)instanceMethod
{
    NSLog(@"NSObject对象方法instanceMethod");
}

@end


#pragma mark - Person
@interface Person : NSObject

@end

@implementation Person

+ (void)class_print
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

// 只能用类来调用类方法，不能使用对象。
void testCallClassMethod () {
    Person *p = [Person new];
    [Person class_print];
//    [p class_print]; // 报编译错误
}

#define MY_ISA_MASK 0x00007ffffffffff8ULL

struct Object_IMPL {
    __unsafe_unretained Class isa;
};

struct Class_IMPL {
    __unsafe_unretained Class isa;
    __unsafe_unretained Class superclass;
};

/*
 获取对象的isaz指针指向的真是地址
 
 之前isa指向的地址就是真实的地址，某个系统之后
 isa指向的不再是真是的地址，需要按位与上一个掩码之后获取真实地址
 */
long long get_real_isa_address (id object) {
    struct Object_IMPL *struct_ptr = (__bridge struct Object_IMPL *)object;
    Class isa = struct_ptr->isa;
    long long isa_value = (long long)isa;
    long long real_address = isa_value & MY_ISA_MASK;
    
    return real_address;
}

/*
 获取对象的isaz指针指向的真是地址
 
 之前isa指向的地址就是真实的地址，某个系统之后
 isa指向的不再是真是的地址，需要按位与上一个掩码之后获取真实地址
 */
long long get_real_superclass_address (id class) {
    struct Class_IMPL *struct_ptr = (__bridge struct Class_IMPL *)class;
    Class superclass = struct_ptr->superclass;
    long long superclass_value = (long long)superclass;
    long long real_address = superclass_value & MY_ISA_MASK;
    
    return real_address;
}

/*
 验证:
 - instance的isa指向class对象
 - class对象的isa指向meta-class对象
 - meta-class对象的isa指向根类的meta-class
 */
void check_isa () {
    Person *instance = [Person new];
    Class class_object =  object_getClass(instance);
    Class meta_class_object = object_getClass(class_object);
    Class root_meta_class_object = object_getClass([NSObject class]);

    NSLog(@"class_object: %p", class_object);
    NSLog(@"meta_class_object: %p", meta_class_object);
    NSLog(@"root_meta_class_object: %p", root_meta_class_object);

    long long instance_isa = get_real_isa_address(instance);
    NSLog(@"instance_isa: 0x%llX", instance_isa);
    
    long long class_object_isa = get_real_isa_address(class_object);
    NSLog(@"class_object_isa: 0x%llx", class_object_isa);
    
    long long meta_class_object_isa = get_real_isa_address(meta_class_object);
    NSLog(@"meta_class_object_isa: 0x%llx", meta_class_object_isa);
}

/*
 验证:
 - 子类的class对象的superclass指向父类class对象
 - 根类的class对象的superclass指向nil(0x0)
 - 子类的meta-class对象的superclass指向父类meta-class对象
 - 根类的meta-class对象的superclass指向根类class对象
 */
void check_superclass () {
    // class对象的superclass
    Class father_class_object =  [NSObject class];
    Class child_class_object = [Person class];
    
    NSLog(@"father_class_object: %p", father_class_object);
    long long child_class_superclass = get_real_superclass_address(child_class_object);
    NSLog(@"child_class_superclass: 0x%llx", child_class_superclass);
    
    long long root_class_superclass = get_real_superclass_address(father_class_object);
    NSLog(@"root_class_superclass: 0x%llx", root_class_superclass);
    
    // meta-class对象的superclass
    Class father_meta_class_objcet = object_getClass(father_class_object);
    Class child_meta_class_objcet = object_getClass(child_class_object);
    NSLog(@"father_meta_class_objcet: %p", father_meta_class_objcet);
    
    long long child_meta_class_superclass = get_real_superclass_address(child_meta_class_objcet);
    NSLog(@"child_meta_class_superclass: 0x%llx", child_meta_class_superclass);
    
    NSLog(@"root__class_object: %p", father_class_object);
    long long root_meta_class_superclass = get_real_superclass_address(father_meta_class_objcet);
    NSLog(@"root_meta_class_superclass: 0x%llx", root_meta_class_superclass);
}

// 验证根类的meta-class对象的superclass指向根类class对象
void check_root_meta_class_superclass_pointer_to_root_class () {
    [Person instanceMethod];
}

//



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        testCallClassMethod ();
        NSLog(@"");
        
        check_isa();
        NSLog(@"");

        check_superclass ();
        NSLog(@"");

        check_root_meta_class_superclass_pointer_to_root_class ();
        NSLog(@"");

    }
    return 0;
}
