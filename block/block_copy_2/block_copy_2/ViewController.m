//
//  ViewController.m
//  block_copy_2
//
//  Created by itang on 2019/11/9.
//  Copyright © 2019 learn. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Person *person = [Person new];
    __weak Person *weakPerson = person;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"person: %@", person); // 3s后释放person
        NSLog(@"person: %@", weakPerson); // 立刻释放person

    });
}


@end
