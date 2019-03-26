//
//  TestLivedThreadVC.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/25.
//  Copyright © 2019 itang. All rights reserved.
//

#import "TestLivedThreadVC.h"
#import "HLWLivedThread.h"

@interface TestLivedThreadVC ()

@property (strong, nonatomic) HLWLivedThread *livedThread;

@end

@implementation TestLivedThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    [self end:nil];
}

- (IBAction)start:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    if (!_livedThread)
    {
        _livedThread = [[HLWLivedThread alloc] init];
        _livedThread.name = @"test";
    }
    
}

- (IBAction)end:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    if (_livedThread)
    {
        [_livedThread end];
        _livedThread = nil;
    }
}
- (IBAction)asyn:(id)sender
{
    NSLog(@"[%@ %@]: ** begin ** ", [self class], NSStringFromSelector(_cmd));
    
    if (_livedThread)
    {
        static int count = 1;
        [_livedThread asynPerformBlock:^{
            NSLog(@"%@ > do something[%d].", [NSThread currentThread].name, count);
            ++count;
        }];
    }
    
    NSLog(@"[%@ %@]: ** end ** ", [self class], NSStringFromSelector(_cmd));
    NSLog(@"");
}

- (IBAction)syn:(id)sender
{
    NSLog(@"[%@ %@]: ** begin ** ", [self class], NSStringFromSelector(_cmd));
    
    if (_livedThread)
    {
        static int count = 1;
        [_livedThread synPerformBlock:^{
            NSLog(@"%@ > do something[%d].", [NSThread currentThread].name, count);
            ++count;
        }];
    }
    
    NSLog(@"[%@ %@]: ** end ** ", [self class], NSStringFromSelector(_cmd));
    NSLog(@"");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_livedThread)
    {
        [_livedThread asynPerformBlock:^{
            NSLog(@"%@ > do something.", [NSThread currentThread].name);
        }];
    }
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
