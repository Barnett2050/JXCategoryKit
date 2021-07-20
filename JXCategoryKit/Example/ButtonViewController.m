//
//  ButtonViewController.m
//  JXCategoryKit
//
//  Created by Barnett on 2021/4/25.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import "ButtonViewController.h"
#import "UIButton+JXGeneral.h"
#import "UIButton+JXShow.h"

@interface ButtonViewController ()

@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UIButton *imageBtn;

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = 0;
    
    self.testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.testBtn.backgroundColor = [UIColor yellowColor];
    [self.testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn setTitle:@"点击" forState:UIControlStateNormal];
    self.testBtn.hitEdgeInsets = UIEdgeInsetsMake(-100, -100, -100, -100);
    [self.view addSubview:self.testBtn];
    [self.testBtn addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.testBtn setEventTimeIntervalWith:3 sendActionBlock:^(SEL  _Nonnull action, id  _Nonnull target, UIEvent * _Nonnull event) {
        NSLog(@"%@ --- %@ --- %@",NSStringFromSelector(action),target,event);
    }];
    [self.testBtn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:188].active = YES;
    [self.testBtn.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:100].active = YES;
    [self.testBtn.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.testBtn.heightAnchor constraintEqualToConstant:50].active = YES;
    
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageBtn.backgroundColor = [UIColor yellowColor];
    [self.imageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.imageBtn setTitle:@"文字" forState:UIControlStateNormal];
    [self.imageBtn setImage:[UIImage imageNamed:@"arrow_gray.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.imageBtn];
    [self.imageBtn addTarget:self action:@selector(imageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:100].active = YES;
    [self.imageBtn.topAnchor constraintEqualToAnchor:self.testBtn.bottomAnchor constant:50].active = YES;
    [self.imageBtn.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.imageBtn.heightAnchor constraintEqualToConstant:100].active = YES;
}

- (void)testButtonAction:(UIButton *)sender
{
    self.number++;
    [sender setTitle:[NSString stringWithFormat:@"%ld",self.number] forState:UIControlStateNormal];
}

- (void)imageBtnAction:(UIButton *)sender
{
    self.number++;
    NSInteger num = self.number % 5;
    [self.imageBtn jx_setButtonStyle:num spacing:10];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.number = 0;
    [self.testBtn setTitle:@"点击" forState:UIControlStateNormal];
}

@end
