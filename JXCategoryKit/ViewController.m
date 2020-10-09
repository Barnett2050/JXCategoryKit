//
//  ViewController.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/22.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "ViewController.h"
#import "NSData+JXEncrypt.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = @"123456789haha";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",[data jx_hexString]);
}

@end
