//
//  UIBarButtonItem+Extension.h
//  XiYuWang
//
//  Created by DDLi on 16/1/7.
//  Copyright © 2016年 DDLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

- (void)initBorderColor:(UIColor *)borderColor
                  Width:(CGFloat)borderWidth;

- (void)initWithcolorChangeSWithRect:(CGRect )sizeFrame
                          startColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor;

/**
 底部增加一横线

 @param lineColor 横线颜色
 @param lineHeight 横线高度
 */
- (void)initBottomLine:(UIColor *)lineColor
                Height:(CGFloat)lineHeight;

@end
