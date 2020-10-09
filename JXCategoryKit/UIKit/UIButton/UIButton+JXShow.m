//
//  UIButton+JXShow.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIButton+JXShow.h"
#import <objc/runtime.h>

@interface UIButton ()
/** 菊花view */
@property (nonatomic, weak) UIActivityIndicatorView *loadIndicatorView;
/** 按钮名称 */
@property (nonatomic, copy) NSString *btnTitle;

@end

@implementation UIButton (JXShow)

- (void)jx_setImagePosition:(JXImagePosition)postion spacing:(CGFloat)spacing
{
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;

    CGFloat labelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].height;
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case JXImageTextPositionNone:
            self.imageEdgeInsets = UIEdgeInsetsZero;
            self.titleEdgeInsets = UIEdgeInsetsZero;
            self.contentEdgeInsets = UIEdgeInsetsZero;
            break;
            
        case JXImageLeftTextRightPosition:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case JXImageRightTextLeftPosition:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case JXImageTopTextBottomPosition:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case JXImageBottomTextTopPosition:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    [self layoutIfNeeded];
}

- (void)jx_startAnimationWithTransform:(CGFloat)transform color:(UIColor *)color isHideTitle:(BOOL)isHideTitle
{
    self.userInteractionEnabled = NO;
    UIActivityIndicatorView *loadIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loadIndicatorView.transform = CGAffineTransformMakeScale(transform, transform);
    loadIndicatorView.color = color;
    self.btnTitle = self.titleLabel.text;
    if (isHideTitle) {
        [self setTitle:nil forState:UIControlStateNormal];
        loadIndicatorView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    [self addSubview:loadIndicatorView];
    [loadIndicatorView startAnimating];
    
    self.loadIndicatorView = loadIndicatorView;
}

- (void)jx_stopAnimationAndShowTitle:(BOOL)isShowTitle {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    
    if (isShowTitle) {
        [self setTitle:self.btnTitle forState:UIControlStateNormal];
    }
    [self.loadIndicatorView stopAnimating];
}
#pragma mark - private
- (void)setLoadIndicatorView:(UIActivityIndicatorView *)loadIndicatorView {
    [self willChangeValueForKey:@"FKLoadIndicatorView"];
    objc_setAssociatedObject(self, @selector(setLoadIndicatorView:),
                             loadIndicatorView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"FKLoadIndicatorView"];
}

- (UIActivityIndicatorView *)loadIndicatorView {
    return objc_getAssociatedObject(self, @selector(loadIndicatorView));
}

- (void)setBtnTitle:(NSString *)btnTitle
{
    [self willChangeValueForKey:@"btnTitle"];
    objc_setAssociatedObject(self, @selector(setBtnTitle:),
                             btnTitle,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"btnTitle"];
}

- (NSString *)btnTitle
{
    return objc_getAssociatedObject(self, @selector(btnTitle));
}
@end
