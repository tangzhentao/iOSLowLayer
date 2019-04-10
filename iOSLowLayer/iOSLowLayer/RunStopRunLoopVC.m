//
//  ViewController.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/21.
//  Copyright © 2019 itang. All rights reserved.
//

#import "RunStopRunLoopVC.h"
#import "HLWThread.h"

@interface RunStopRunLoopVC ()

@property (weak, nonatomic) HLWThread *thread;
@property (assign, nonatomic) BOOL shouldKeepRunning;



@end

@implementation RunStopRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shouldKeepRunning = YES;
}

- (void)dealloc
{
    [self end:nil];
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (IBAction)start:(id)sender
{
//    [self startSubthreadWithRun];

//    [self startSubthread];
    
    [self startSubthread_c];

    
}

- (void)startSubthreadWithRun
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    self.shouldKeepRunning = YES;
    
    __weak typeof(self) weakSelf = self;
    HLWThread *thread = [[HLWThread alloc] initWithBlock:^{
        
        NSLog(@"%@ > *** begin ***.", [NSThread currentThread].name);
        
        [weakSelf printRunLoopActivity];
        
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        
        /*
         通过[[NSRunLoop currentRunLoop] run] 开启运行循环有以下特点：
         1、在事件到来之前，睡觉
         2、处理事件之后，退出
         3、退出之后立刻，进入
         4、由于退出后会立刻进入，所以CFRunLoopStop(CFRunLoopGetCurrent())无法停止runloop。
         
         总结：
         [[NSRunLoop currentRunLoop] run] 内部是重复调用 runMode:beforeDate: 方法；
         runloop 会不断的entry、exit。
         */
        [[NSRunLoop currentRunLoop] run];
        
        //        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
        NSLog(@"%@ > *** end ***.", [NSThread currentThread].name);
    }];
    
    
    /*
     这种情况下，不结束运行循环返回上一页面时，当前控制器不会被释放。
     可能是子线程引用了当前控制器
     MyThread *thread = [[MyThread alloc] initWithTarget:weakSelf selector:@selector(run) object:nil];
     */
    self.thread = thread;
    thread.name = @"my thread";
    [thread start];
}


- (void)startSubthread
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    self.shouldKeepRunning = YES;
    
    __weak typeof(self) weakSelf = self;
    HLWThread *thread = [[HLWThread alloc] initWithBlock:^{
        
        NSLog(@"%@ > *** begin ***.", [NSThread currentThread].name);
        
        [weakSelf printRunLoopActivity];
        
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        
        /*
         通过[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]] 开启运行循环有以下特点：
         1、在事件到来之前，睡觉
         2、处理事件之后，退出
         3、退出之后立刻，进入
         4、使用CFRunLoopStop(CFRunLoopGetCurrent()) 并配合标记shouldKeepRunning，可以停止runloop。
         
         runloop 会不断的entry、exit。
         */
        int cout = 1;
        while (weakSelf.shouldKeepRunning)
        {
            NSLog(@"%@ > ** run loop run %d begin.", [NSThread currentThread].name, cout);
            
            BOOL success = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"%@ > ** run loop run %d end[%d].", [NSThread currentThread].name, cout, success);
            NSLog(@"weakSelf: %@", weakSelf);
            
            ++cout;
        }
        
        NSLog(@"%@ > *** end ***.", [NSThread currentThread].name);
    }];
    
    
    /*
     这种情况下，不结束运行循环返回上一页面时，当前控制器不会被释放。
     可能是子线程引用了当前控制器
     MyThread *thread = [[MyThread alloc] initWithTarget:weakSelf selector:@selector(run) object:nil];
     
     */
    self.thread = thread;
    thread.name = @"my thread";
    [thread start];
}

/*
 C语言版，开启子线程
 */
- (void)startSubthread_c
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    self.shouldKeepRunning = YES;
    
    __weak typeof(self) weakSelf = self;
    HLWThread *thread = [[HLWThread alloc] initWithBlock:^{
        
        NSLog(@"%@ > *** begin ***.", [NSThread currentThread].name);
        
        [weakSelf printRunLoopActivity];
        
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        
        /*
         通过CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false) 开启运行循环有以下特点：
         与一下方式开启运行循环有一样的效果：
         [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]] + shouldKeepRunning
         
         总结：
         CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false) 更简洁
         */
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        NSLog(@"%@ > *** end ***.", [NSThread currentThread].name);
    }];
    
    
    /*
     这种情况下，不结束运行循环返回上一页面时，当前控制器不会被释放。
     可能是子线程引用了当前控制器
     MyThread *thread = [[MyThread alloc] initWithTarget:weakSelf selector:@selector(run) object:nil];
     
     */
    self.thread = thread;
    thread.name = @"my thread";
    [thread start];
}

- (void)doSomething
{
    //NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), [NSThread currentThread].name);
    [self performSelector:@selector(doSomethingOnSubthread) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)doSomethingOnSubthread
{
    NSLog(@"%@ > do something ...", [NSThread currentThread].name);
}

- (IBAction)end:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    /*
     waitUntilDone:YES : 等待子线程执行完毕，防止在dealloc中停止runloop时，本控制器已经释放而runloop还在访问本控制器。
     */
    
    if (self.thread) {
        NSLog(@"** begin end subthread.");
        [self performSelector:@selector(stopOnSubthread) onThread:self.thread withObject:nil waitUntilDone:YES];
        NSLog(@"** finish end subthread.");
    }

}

- (void)stopOnSubthread
{
    NSLog(@"%@ > [%@ %@]", [NSThread currentThread].name, [self class], NSStringFromSelector(_cmd));

    self.shouldKeepRunning = NO;
    
    /*
     如果不主动停止runloop，runloop需要等到一个事件并处理后才会退出。
     */
    CFRunLoopStop(CFRunLoopGetCurrent());
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 打个断点看下runloop的入口函数
    [self doSomething];
}

- (void)printRunLoopActivity
{
    // create run loop observer
    CFRunLoopObserverRef observer =  CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {

        switch (activity) {
            case kCFRunLoopEntry:
            {
                NSLog(@"kCFRunLoopEntry");
            }
                break;
                
            case kCFRunLoopBeforeTimers:
            {
                NSLog(@"kCFRunLoopBeforeTimers");
            }
                break;
                
            case kCFRunLoopBeforeSources:
            {
                NSLog(@"kCFRunLoopBeforeSources");
            }
                break;
                
            case kCFRunLoopBeforeWaiting:
            {
                NSLog(@"kCFRunLoopBeforeWaiting");
            }
                break;
                
            case kCFRunLoopAfterWaiting:
            {
                NSLog(@"kCFRunLoopAfterWaiting");
            }
                break;
                
            case kCFRunLoopExit:
            {
                NSLog(@"kCFRunLoopExit");
            }
                break;
                
            default:
                break;
        }
    });
    
    // add observer to run loop
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    
    // release observer
    CFRelease(observer);
}


@end
