//
//  TableViewController.m
//  iOSLowLayer
//
//  Created by tang on 2019/3/22.
//  Copyright © 2019 genghaowan. All rights reserved.
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
            
        default:
            break;
    }
}

@end
