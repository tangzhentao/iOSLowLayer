//
//  TableViewController.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/22.
//  Copyright © 2019 itang. All rights reserved.
//

#import "TableViewController.h"

#import "RunStopRunLoopVC.h"
#import "LearnItem.h"

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    [_dataArray addObjectsFromArray:@[
                                      [LearnItem learnItemWithType:LearnItemTypeRunStopRunLoop title:@"Run Stop RunLoop"],
                                      [LearnItem learnItemWithType:LearnItemTypeLivedThread title:@" Lived Thread"],
                                      [LearnItem learnItemWithType:LearnItemTypeAsynExecuteTaskInMainQueue title:@"AsynExecuteTaskInMainQueue"],
                                      [LearnItem learnItemWithType:LearnItemTypeSynExecuteTaskInMainQueue title:@"SynExecuteTaskInMainQueue"],
                                      [LearnItem learnItemWithType:LearnItemTypeDeadlockWhenSynExecuteTaskInSerialQueue title:@"DeadlockWhenSynExecuteTaskInSerialQueue"],
                                      [LearnItem learnItemWithType:LearnItemTypeGlobalQueueIsOneQueue title:@"GlobalQueueIsOneQueue"],
                                      ]];
    
     [self printRunLoopActivity];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 打个断点看下runloop的入口函数
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)printRunLoopActivity
{
    // create run loop observer
    CFRunLoopObserverRef observer =  CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopEntry | kCFRunLoopExit, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
            {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"RunLoopEntry, %@", mode);
                CFRelease(mode);
            }
                break;
                
            case kCFRunLoopExit:
            {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"RunLoopExit, %@", mode);
                CFRelease(mode);
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
 
    LearnItem *item = (LearnItem *)self.dataArray[indexPath.row];

    cell.textLabel.text = item.title;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LearnItem *item = (LearnItem *)self.dataArray[indexPath.row];
    [self dispatchEventWithType:item.type];
}

- (void)dispatchEventWithType:(LearnItemType)type
{
    switch (type) {
        case LearnItemTypeRunStopRunLoop:
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RunStopRunLoopVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case LearnItemTypeLivedThread:
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"TestLivedThreadVC" bundle:nil];
            UIViewController *vc = sb.instantiateInitialViewController;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case LearnItemTypeAsynExecuteTaskInMainQueue:
        {// 根据是否阻塞主线程，理解syn和asyn
            
            
            /*
             在主线程中，安排任务在主队列中异步执行不会造成主线程死锁
             */
            NSLog(@"AsynExecuteTaskInMainQueue begin...");
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
            // 异步
            dispatch_async(mainQueue, ^{
                NSLog(@"async perform task, %@", [NSThread currentThread]);
            });
            
            NSLog(@"AsynExecuteTaskInMainQueue end***");

        }
            break;
            
        case LearnItemTypeSynExecuteTaskInMainQueue:
        {// 根据是否阻塞主线程，理解syn和asyn
            
            /*
             在主线程中，安排任务在主队列中同步执行会造成主线程死锁
             因为主队列是主线程的任务队列。在主队列中的任务，会在主线程中执行。
             同步执行主队列中的任务就是：等主队列中的上个任务执行完成后执行该任务。而上个任务就是包含该任务的函数。
             */
            NSLog(@"SynExecuteTaskInMainQueue begin...");
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
            // 异步
            dispatch_sync(mainQueue, ^{
                NSLog(@"sync perform task, %@", [NSThread currentThread]);
            });
            
            NSLog(@"SynExecuteTaskInMainQueue end***");
            
        }
            break;
            
        case LearnItemTypeDeadlockWhenSynExecuteTaskInSerialQueue:
        {
            /*
             在串行队列中同步执行任务2时会死锁，如果任务2的上一个任务 任务1包含任务2.
             因为，同步执行串行队列中的任务时，是要等到队列中的上一个任务执行完成后，才会执行下一个任务。
             */
            NSLog(@"Deadlock begin...");
            
            dispatch_queue_t serialQueue = dispatch_queue_create("serial queue", DISPATCH_QUEUE_SERIAL);
            
            dispatch_async(serialQueue, ^{
                
                NSLog(@"task 1");
                
                dispatch_sync(serialQueue, ^{
                    NSLog(@"task 2");
                });
            });
            
            NSLog(@"Deadlock end***");
            
        }
            break;
            
        case LearnItemTypeGlobalQueueIsOneQueue:
        {
            /*
             获取全局队列时，如果优先级相同，得到的队列也相同。
             */
            
            dispatch_queue_t globalQueueBg = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
            dispatch_queue_t globalQueueBg1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

            dispatch_queue_t globalQueueLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
            dispatch_queue_t globalQueueLow1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);

            dispatch_queue_t globalQueueDefault = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t globalQueueDefault1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

            dispatch_queue_t globalQueueHight = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_queue_t globalQueueHight1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

            NSLog(@"globalQueueBg: %p", globalQueueBg);
            NSLog(@"globalQueueBg1: %p", globalQueueBg1);

            NSLog(@"globalQueueLow: %p", globalQueueLow);
            NSLog(@"globalQueueLow1: %p", globalQueueLow1);

            NSLog(@"globalQueueDefault: %p", globalQueueDefault);
            NSLog(@"globalQueueDefault1: %p", globalQueueDefault1);

            NSLog(@"globalQueueHight: %p", globalQueueHight);
            NSLog(@"globalQueueHight1: %p", globalQueueHight1);

        }
            break;
            //
            
            
        default:
            break;
    }
}

@end
