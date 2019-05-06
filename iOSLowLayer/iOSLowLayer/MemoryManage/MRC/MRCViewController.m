//
//  MRCViewController.m
//  iOSLowLayer
//
//  Created by itang on 2019/5/1.
//  Copyright © 2019 itang. All rights reserved.
//

#import "MRCViewController.h"

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
        
        NSMutableString
    }
}

- (void)setDogs:(NSMutableArray *)dogs
{
    if (_dogs != dogs) {
        [_dogs release];
        _dogs = [dogs copy]; // 将导致返回一个不可变数组NSArray，因copy返回的就是不可变对象
    }
}

//@synthesize name;
- (IBAction)biubiu:(id)sender
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setName:@"job"];
    
    NSLog(@"name: %@", self.name);
    
    self.retainCount
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
