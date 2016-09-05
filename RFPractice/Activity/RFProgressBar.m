//
//  RFProgressBar.m
//  RFPractice
//
//  Created by zhouweiou on 16/9/5.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFProgressBar.h"

@implementation RFProgressBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _leftEndColor=[UIColor orangeColor];
        _rightEndColor=[UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Gradient Declarations
    CGFloat indicatorInnerGradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)self.leftEndColor.CGColor, (id)self.rightEndColor.CGColor], indicatorInnerGradientLocations);
    
    CGFloat cornerRadius = self.bounds.size.height/2;
    
    // white bg
    UIBezierPath *whiteBG=[UIBezierPath bezierPathWithRect:self.bounds];
    [[UIColor whiteColor] setFill];
    [whiteBG fill];
    
    // grey path
    UIBezierPath *greyPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    [RFRGBColor(240, 240, 240) setFill];
    [greyPath fill];
    
    // color path
    CGFloat colorPathWidth=self.bounds.size.width*self.percentage;
    BOOL shouldDraw=colorPathWidth > 1.0;
    if (colorPathWidth < 2*cornerRadius) {
        colorPathWidth = 2*cornerRadius;
    }
    if (colorPathWidth>self.bounds.size.width) {
        colorPathWidth=self.bounds.size.width;
    }
    
    if (shouldDraw) {
        UIBezierPath *colorPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, colorPathWidth, self.bounds.size.height) cornerRadius:cornerRadius];
        CGContextSaveGState(context);
        [colorPath addClip];
        CGContextDrawLinearGradient(context, gradient,
                                    CGPointMake(0, cornerRadius),
                                    CGPointMake(colorPathWidth, cornerRadius),
                                    0);
        CGContextRestoreGState(context);
    }
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@end
