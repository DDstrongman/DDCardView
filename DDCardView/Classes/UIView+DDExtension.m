//
//  UIBarButtonItem+Extension.h
//  XiYuWang
//
//  Created by DDLi on 16/1/7.
//  Copyright © 2016年 DDLi. All rights reserved.
//

#import "UIView+DDExtension.h"
#import <objc/runtime.h>

@implementation UIView (DDExtension)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width ;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)initBorderColor:(UIColor *)borderColor Width:(CGFloat)borderWidth {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)initWithcolorChangeSWithRect:(CGRect )sizeFrame
                          startColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor {
    // 如果已经有这个类型layer了，那就只需要改变他的frame即可 不用重复创建
    __block CAGradientLayer *gradient;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAGradientLayer class]]) {
            gradient = (CAGradientLayer *)obj;
        }
    }];
    if (gradient == nil) {
        gradient = [CAGradientLayer layer];
    }
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    gradient.frame = sizeFrame;
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor,(id)endColor.CGColor,nil];
    
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)initBottomLine:(UIColor *)lineColor
                Height:(CGFloat)lineHeight {
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - lineHeight, self.frame.size.width, lineHeight)];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];
}


@end
