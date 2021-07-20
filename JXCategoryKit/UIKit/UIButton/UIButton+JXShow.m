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

@property (nonatomic, assign, readwrite) JXButtonShowStyle buttonShowStyle;

@end

@implementation UIButton (JXShow)

- (void)jx_setButtonStyle:(JXButtonShowStyle)style spacing:(CGFloat)spacing
{
    self.buttonShowStyle = style;
    
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
    
    switch (style) {
        case JXButtonShowStyleNormal:
            self.imageEdgeInsets = UIEdgeInsetsZero;
            self.titleEdgeInsets = UIEdgeInsetsZero;
            self.contentEdgeInsets = UIEdgeInsetsZero;
            break;
            
        case JXButtonShowStyleImageLeftTextRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case JXButtonShowStyleImageRightTextLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case JXButtonShowStyleImageTopTextBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case JXButtonShowStyleImageBottomTextTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark - private
- (void)setButtonShowStyle:(JXButtonShowStyle)buttonShowStyle
{
    NSNumber *number = [NSNumber numberWithInteger:buttonShowStyle];
    objc_setAssociatedObject(self, @selector(setButtonShowStyle:),
                             number,
                             OBJC_ASSOCIATION_ASSIGN);
}
- (JXButtonShowStyle)buttonShowStyle
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(buttonShowStyle));
    return [number integerValue];
}

@end
