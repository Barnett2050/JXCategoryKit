//
//  GestureViewController.m
//  JXCategoryKit
//
//  Created by Barnett on 2021/7/20.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import "GestureViewController.h"
#import "UIGestureRecognizer+JXBlock.h"

@interface GestureViewController ()

@property (strong, nonatomic) IBOutlet UIView *gestureView;
@property (nonatomic, strong) UITapGestureRecognizer *gesture;
@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gestureView.userInteractionEnabled = YES;
}
- (IBAction)createGestureAction:(id)sender {
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"========点击");
    }];
    [self.gestureView addGestureRecognizer:tapGesture];
}
- (IBAction)addGestureAction:(id)sender {
    self.gesture = [[UITapGestureRecognizer alloc] init];
    self.gesture.numberOfTapsRequired = 2;
    [self.gesture addActionBlock:^(id  _Nonnull sender) {
        NSLog(@"=========双击");
    }];
    [self.gestureView addGestureRecognizer:self.gesture];
}
- (IBAction)removeGestureAction:(id)sender {
    [self.gesture removeAllActionBlocks];
}

@end
