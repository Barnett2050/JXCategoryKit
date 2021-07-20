//
//  ControlViewController.m
//  JXCategoryKit
//
//  Created by Barnett on 2021/7/14.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import "ControlViewController.h"
#import "UIControl+JXEvents.h"

@interface ControlViewController ()

@property (strong, nonatomic) UIControl *testControl;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *addBlockButton;
@property (strong, nonatomic) UIButton *removeBlockButton;
@property (strong, nonatomic) UIButton *removeButton;

@end

@implementation ControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testControl = [[UIControl alloc] init];
    self.testControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.testControl.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.testControl];
    [self.testControl.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:88].active = YES;
    [self.testControl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.testControl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [self.testControl.heightAnchor constraintEqualToConstant:100].active = YES;
    
    self.removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.removeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.removeButton.backgroundColor = [UIColor redColor];
    [self.removeButton setTitle:@"删除控件所有事件" forState:UIControlStateNormal];
    [self.view addSubview:self.removeButton];
    [self.removeButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:0].active = YES;
    [self.removeButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.removeButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [self.removeButton.heightAnchor constraintEqualToConstant:50].active = YES;
    [self.removeButton addTarget:self action:@selector(removeAllAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.removeBlockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.removeBlockButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.removeBlockButton.backgroundColor = [UIColor redColor];
    [self.removeBlockButton setTitle:@"删除控件block事件" forState:UIControlStateNormal];
    [self.view addSubview:self.removeBlockButton];
    [self.removeBlockButton.bottomAnchor constraintEqualToAnchor:self.removeButton.topAnchor constant:-10].active = YES;
    [self.removeBlockButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.removeBlockButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [self.removeBlockButton.heightAnchor constraintEqualToConstant:50].active = YES;
    [self.removeBlockButton addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.addBlockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBlockButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addBlockButton.backgroundColor = [UIColor redColor];
    [self.addBlockButton setTitle:@"添加控件Block事件" forState:UIControlStateNormal];
    [self.view addSubview:self.addBlockButton];
    [self.addBlockButton.bottomAnchor constraintEqualToAnchor:self.removeBlockButton.topAnchor constant:-10].active = YES;
    [self.addBlockButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.addBlockButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [self.addBlockButton.heightAnchor constraintEqualToConstant:50].active = YES;
    [self.addBlockButton addTarget:self action:@selector(addActionBlock) forControlEvents:UIControlEventTouchUpInside];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addButton.backgroundColor = [UIColor redColor];
    [self.addButton setTitle:@"添加控件事件" forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    [self.addButton.bottomAnchor constraintEqualToAnchor:self.addBlockButton.topAnchor constant:-10].active = YES;
    [self.addButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.addButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [self.addButton.heightAnchor constraintEqualToConstant:50].active = YES;
    [self.addButton addTarget:self action:@selector(testControlAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addAction {
    [self.testControl jx_setTarget:self action:@selector(testControlAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addActionBlock {
    [self.testControl jx_setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self testControlAction];
    }];
}
- (void)removeAction {
    [self.testControl jx_removeAllBlocksForControlEvents:UIControlEventTouchUpInside];
}
- (void)removeAllAction {
    [self.testControl jx_removeAllTargets];
}

- (void)testControlAction {
    self.testControl.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha:1.];
}

@end
