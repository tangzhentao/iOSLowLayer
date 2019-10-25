//
//  ViewController.m
//  KVO
//
//  Created by itang on 2019/10/20.
//  Copyright © 2019 itang. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

# if __arm64__
#   define ISA_MASK        0x0000000ffffffff8ULL
# elif __x86_64__
#   define ISA_MASK        0x00007ffffffffff8ULL
# else
#   error unknown architecture for packed isa
# endif

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
    long long real_address = isa_value & ISA_MASK;
    
    return real_address;
}

#pragma mark - Person
@interface Person : NSObject

@property (assign, nonatomic) int age;

@end

@implementation Person
@end


#pragma mark - ViewController
@interface ViewController ()

@property (strong, nonatomic) Person *p1;
@property (strong, nonatomic) Person *p2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.p1 = [Person new];
    self.p1.age = 1;
    self.p2 = [Person new];
    self.p2.age = 2;
    
    NSLog(@"监听前p1: %p, isa: 0x%016llx, setAge: %p, 所属的类: %@(%p), ", self.p1, get_real_isa_address(self.p1), [self.p1 methodForSelector:@selector(setAge:)], object_getClass(self.p1), object_getClass(self.p1));
    [self.p1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew  context:nil];
    NSLog(@"监听后p1: %p, isa: 0x%016llx, setAge: %p, 所属的类: %@(%p), ", self.p1, get_real_isa_address(self.p1), [self.p1 methodForSelector:@selector(setAge:)], object_getClass(self.p1), object_getClass(self.p1));
    
    /*
     找到了，实现的四个方法。没有找到observer存储在哪
     */
    Class child_cls = object_getClass(self.p1);
    NSLog(@"%@方法:", child_cls);
    [self printMethodsOfClass:child_cls];
    NSLog(@"%@成员变量:", child_cls);
    [self printInstanceVarNamesOfClass:child_cls];
    NSLog(@"%@属性:", child_cls);
    [self printPropertyNamesOfClass:child_cls];
}

- (void)printMethodsOfClass:(Class)cls
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

- (void)printInstanceVarNamesOfClass:(Class)cls
{
    // 获取成员变量列表
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(cls, &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        // 获取成员变量名
        const char *ivarName = ivar_getName(ivar);
        NSLog(@"%s", ivarName);
    }
    
    // C函数中以名字中有copy、create、new的函数返回的内存需要手动释放
    free(ivarList);
}

- (void)printPropertyNamesOfClass:(Class)cls
{
    // 获取成员变量列表
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(cls, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        // 获取成员变量名
        const char *propertyName = property_getName(property);
        NSLog(@"%s", propertyName);
    }
    
    // C函数中以名字中有copy、create、new的函数返回的内存需要手动释放
    free(propertyList);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"object: %@", object);
    NSLog(@"keyPath: %@", keyPath);
    NSLog(@"change: %@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.p1.age = 2;
}

- (void)dealloc
{
    [self.p1 removeObserver:self forKeyPath:@"age"];
}


@end

@interface _NSKVONotifying_Person : Person

@end

@implementation _NSKVONotifying_Person

- (void)setAge:(int)age
{
    [super setAge:age];
}

@end
