//
//  UIView+JXDraw.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIView+JXDraw.h"

@implementation UIView (JXDraw)

/**
 使用CAShapeLayer和UIBezierPath设置圆角，对内存的消耗最少，而且渲染快速
 注意：view的frame必须已知，自动布局调入另一个传入frame方法
 */
- (void)jx_addRectCornerWith:(CGRect)viewBounds corner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:viewBounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = viewBounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}
- (void)jx_addRectCornerWith:(UIRectCorner)rectCorner cornerRadius:(CGFloat)radius
{
    [self jx_addRectCornerWith:self.bounds corner:rectCorner cornerRadius:radius];
}
/**
 添加全圆角
 */
- (void)jx_addAllCornerWith:(CGFloat)radius
{
    [self jx_addRectCornerWith:UIRectCornerAllCorners cornerRadius:radius];
}
- (void)jx_addAllCornerWith:(CGRect)viewBounds radius:(CGFloat)radius
{
    [self jx_addRectCornerWith:viewBounds corner:UIRectCornerAllCorners cornerRadius:radius];
}

- (void)jx_drawDashLineWithpointArray:(NSArray *)pointArr lineWidth:(float)lineWidth lineLength:(float)lineLength lineSpacing:(float)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为lineColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:lineWidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线长度，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point = CGPointFromString(pointArr[0]);
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    
    for (NSInteger i=1; i<pointArr.count; i++) {
        CGPoint point = CGPointFromString(pointArr[i]);
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

@end
