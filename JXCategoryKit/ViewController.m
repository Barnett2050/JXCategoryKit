//
//  ViewController.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/22.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "ViewController.h"
#import "NSString+JXSize.h"
#import "NSString+JXGeneral.h"
#import "NSString+Encrypt.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *email = @"这是一段神奇的代码";
    NSLog(@"%@",[email jx_encryptWithDES_Key:@"key" desIv:@"qwertyui" isUseBase64:YES]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

@end
