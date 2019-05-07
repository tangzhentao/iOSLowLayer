//
//  MRCViewController.m
//  iOSLowLayer
//
//  Created by itang on 2019/5/1.
//  Copyright © 2019 itang. All rights reserved.
//

#import "MRCViewController.h"

@interface Foo: NSObject

@property (copy, nonatomic) NSMutableArray *dataArray;

@end

@implementation Foo
@end



@interface MRCViewController ()

@end

@implementation MRCViewController

- (void)setFirstName:(NSString *)firstName
{
    if (_firstName != firstName) {
        [_firstName release];
        _firstName = [firstName copy];
    }
}

- (void)setLastName:(NSString *)lastName
{
    if (_lastName != lastName) {
        [_lastName release];
        _lastName = [lastName copy];
    }
}

- (void)setDogs:(NSMutableArray *)dogs
{
    if (_dogs != dogs) {
        [_dogs release];
        _dogs = [dogs copy]; // 将导致返回一个不可变数组NSArray，因copy返回的就是不可变对象
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)taggedObjectReferenceCount:(id)sender
{
    /*
     这种小数值的number本来应该使用Tagged Pointer技术来存储的
     不知道为啥不是Tagged Pointer对象了；
     */
    NSNumber *number1 = @1;
    NSNumber *number2 = @2;
    NSNumber *number3 = @3;
    NSNumber *number4 = @0xffffffff;
    
    NSLog(@"number1: %p", number1);
    NSLog(@"number2: %p", number2);
    NSLog(@"number3: %p", number3);
    NSLog(@"number4: %p", number4);
    
    /*
     Tagged Pointer 对象的引用计数是long的最大值，因为它其实不是一个oc 对象；
     字符常量的引用计数是long的最大值，因为它一直在内存中存在直到程序结束，所以不需要用引用计数来管理内存；
     */
    NSString *str1 = @"hello";
    NSString *str2 = [NSString stringWithFormat:@"%@", str1]; // Tagged Pointer 对象
    NSMutableString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1<%p:%@>, retain count: %lu, %@", str1, [str1 class], str1.retainCount, str1);
    NSLog(@"str2<%p:%@>, retain count: %lu, %@", str2, [str2 class], str2.retainCount, str2);
    NSLog(@"str3<%p:%@>, retain count: %lu, %@", str3, [str3 class], str3.retainCount, str3);
}

// 浅拷贝、深拷贝
- (IBAction)shallowCopDeepCopy:(id)sender
{
    // 浅拷贝
    NSMutableString *mutableName = [NSMutableString stringWithString:@"James"];
    NSArray *names = @[mutableName];
    NSArray *namesCopy = [names copy];
    
    NSLog(@"names: %p, name: %p", names, names.firstObject);
    NSLog(@"namesCopy: %p, name: %p", namesCopy, namesCopy.firstObject);
    
    // 浅拷贝
    NSMutableArray *mutableNames = [names mutableCopy];
    NSLog(@"mutableNames: %p, name: %p", mutableNames, mutableNames.firstObject);
}

#pragma mark - copy 可变数据
- (IBAction)copyMutableObject:(id)sender
{
    // 浅拷贝
    NSMutableArray *data = [NSMutableArray array];
    [data addObject:@"1"];
    
    Foo *foo = [Foo new];
    foo.dataArray = data;
    
    /*
     运行到这里会崩溃。
     因为Foo的dataArray属性是用copy修饰的，所以Foo对象copy到的是个不可变数组NSAarry
     所以向一个不可变数组中添加对象会崩溃
     */
    [foo.dataArray addObject:@"2"];
    
}

@end
