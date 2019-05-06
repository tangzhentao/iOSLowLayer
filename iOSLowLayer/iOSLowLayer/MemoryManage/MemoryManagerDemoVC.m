//
//  MemoryManagerDemoVC.m
//  iOSLowLayer
//
//  Created by tang on 2019/4/22.
//  Copyright © 2019 itang. All rights reserved.
//

#import "MemoryManagerDemoVC.h"
#import "HLWTimerTarget.h"
#import "HLWTargetProxy.h"



@interface Foo: NSObject

@property (copy, nonatomic) NSMutableArray *dataArray;

@end

@implementation Foo
@end

@interface MemoryManagerDemoVC ()

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) HLWTimerTarget *timerTarget;
@property (strong, nonatomic) HLWTargetProxy *targetProxy;


@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation MemoryManagerDemoVC
#pragma clang diagnostic pop

#pragma mark - forward message speed NSObject VS NSProxy

/*
 经过测试发现HLWTimerTarget转发消息比HLWTargetProxy更快
 */
- (IBAction)testNSObjectSubclass:(id)sender
{
    if (!_timerTarget) {
        _timerTarget = [HLWTimerTarget timerTargetWithRealTarget:self];
    }
    [self testForwardMessagesSpeed:_timerTarget];
}

- (IBAction)testNSProxySubclass:(id)sender
{
    if (!_targetProxy) {
        _targetProxy = [HLWTargetProxy targetProxyWithTarget:self];
    }
    [self testForwardMessagesSpeed:_targetProxy];
}

extern void _objc_autoreleasePoolPrint(void);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _objc_autoreleasePoolPrint();
}

- (IBAction)time:(id)sender
{
    
    //    [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(print) userInfo:nil repeats:YES];
    
    // 解决方法一：使用block
    /*
     __weak typeof(self) weakSelf = self;
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
     [weakSelf print];
     }];
     */
    
    if (!self.timer)
    {
        // 解决方法二：使用中间对象
        _timerTarget = [HLWTimerTarget timerTargetWithRealTarget:self];
        _targetProxy = [HLWTargetProxy targetProxyWithTarget:self];
        
        /*
         self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:_timerTarget selector:@selector(print) userInfo:nil repeats:YES];
         */
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:_targetProxy selector:@selector(print) userInfo:nil repeats:YES];
        
        [(UIButton *)sender setTitle:@"    停止计时器    " forState:UIControlStateNormal];
        [(UIButton *)sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    } else
    {
        [self.timer invalidate];
    }
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


- (void)print
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)testForwardMessagesSpeed:(id)objectToTest
{
    NSDate *starTime = [NSDate date];
    int times = 1000;
    for (int i = 0; i < times; i++) {
        [objectToTest performSelector:@selector(print) withObject:nil];
    }
    NSDate *endTime = [NSDate date];
    
    NSTimeInterval duration = [endTime timeIntervalSinceDate:starTime];
    NSLog(@"%@: forward %d times, consume: %f", NSStringFromClass([objectToTest class]), times, duration);
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    [self.timer invalidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
