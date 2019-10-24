//
//  ViewController.m
//  KVO
//
//  Created by itang on 2019/10/20.
//  Copyright © 2019 itang. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#pragma mark - Person
@interface Person : NSObject

@property (assign, nonatomic) int age;

@end

@implementation Person
@end


#pragma mark - ViewController
@interface ViewController ()

@property (strong, nonatomic) Person *p1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.p1 = [Person new];
    self.p1.age = 1;
    
    NSLog(@"监听前: %@", object_getClass(self.p1));
    [self.p1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew  context:nil];
    NSLog(@"监听后: %@", object_getClass(self.p1));
 
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
