//
//  ViewController.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/21.
//  Copyright © 2019 genghaowan. All rights reserved.
//

#import "RunStopRunLoopVC.h"
#import "MyThread.h"

@interface RunStopRunLoopVC ()

@property (weak, nonatomic) MyThread *thread;
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
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    [self end:nil];
}

- (IBAction)start:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    self.shouldKeepRunning = YES;

    __weak typeof(self) weakSelf = self;
    MyThread *thread = [[MyThread alloc] initWithBlock:^{
        
        NSLog(@"%@ > *** begin ***.", [NSThread currentThread].name);

        [weakSelf printRunLoopActivity];

        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];

        /*
         runloop 处理一次事件后，就会推出，没有事件时，就会睡眠等待事件。
         退出后，又会立刻进入，等待下一次事件。
         
         runloop 会不断的entry、exit。
         */
        int cout = 1;
        while (weakSelf.shouldKeepRunning)
        {
            NSLog(@"%@ > ** run loop run %d begin.", [NSThread currentThread].name, cout);

            BOOL success = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"%@ > ** run loop run %d end[%d].", [NSThread currentThread].name, cout, success);
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

- (void)print
{
    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), [NSThread currentThread].name);
    [self performSelector:@selector(printOnSubthread) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)printOnSubthread
{
    NSLog(@"%@ > do something ...", [NSThread currentThread].name);
}

- (IBAction)end:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    [self performSelector:@selector(stopOnSubthread) onThread:self.thread withObject:nil waitUntilDone:YES];

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
    [self print];
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
