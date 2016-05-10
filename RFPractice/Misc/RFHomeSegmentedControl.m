//
//  RFHomeSegmentedControl.m
//  RFPractice
//
//  Created by zwo on 16/5/10.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFHomeSegmentedControl.h"

@implementation RFHomeSegmentedControl
{
    UIButton *_leftButton;
    UIButton *_rightButton;
}

- (instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=Color_White;
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font=Font_Big;
        [_leftButton setTitle:leftTitle forState:UIControlStateNormal];
        [_leftButton setTitleColor:Color_White forState:UIControlStateNormal];
        _leftButton.tag=1;
        [_leftButton addTarget:self action:@selector(onSegmentButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_leftButton];
        _leftButton.frame=CGRectMake(0.0, 0.0, CGRectGetWidth(frame)/2, CGRectGetHeight(frame));
        
        _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font=Font_Big;
        [_rightButton setTitle:rightTitle forState:UIControlStateNormal];
        [_rightButton setTitleColor:Color_Main forState:UIControlStateNormal];
        _rightButton.tag=2;
        [_rightButton addTarget:self action:@selector(onSegmentButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_rightButton];
        _rightButton.frame=CGRectMake(CGRectGetWidth(frame)/2, 0.0, CGRectGetWidth(frame)/2, CGRectGetHeight(frame));
        
    }
    return self;
}

- (void)onSegmentButton:(UIButton *)sender
{
    if (_selectedIndex != sender.tag-1) {
        _selectedIndex=sender.tag-1;
        if (sender.tag==1) {
            [_leftButton setTitleColor:Color_White forState:UIControlStateNormal];
            [_rightButton setTitleColor:Color_Main forState:UIControlStateNormal];
        } else {
            [_leftButton setTitleColor:Color_Main forState:UIControlStateNormal];
            [_rightButton setTitleColor:Color_White forState:UIControlStateNormal];
        }
        [self setNeedsDisplay];
        if (self.handleSelectBlock) {
            self.handleSelectBlock(_selectedIndex);
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex=selectedIndex;
        if (selectedIndex==0) {
            [_leftButton setTitleColor:Color_White forState:UIControlStateNormal];
            [_rightButton setTitleColor:Color_Main forState:UIControlStateNormal];
        } else {
            [_leftButton setTitleColor:Color_Main forState:UIControlStateNormal];
            [_rightButton setTitleColor:Color_White forState:UIControlStateNormal];
        }
        [self setNeedsDisplay];        
    }
}

- (void)setLeftTitle:(NSString *)title
{
    [_leftButton setTitle:title forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)title
{
    [_rightButton setTitle:title forState:UIControlStateNormal];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect selfRect=self.bounds;
    if (_selectedIndex==0) {
        
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, CGRectGetWidth(selfRect)/2, CGRectGetHeight(selfRect)) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(CGRectGetWidth(selfRect)/2, CGRectGetWidth(selfRect)/2)];
        [rectanglePath closePath];
        [Color_Main setFill];
        [rectanglePath fill];
        
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetWidth(selfRect)/2, 1, CGRectGetWidth(selfRect)/2-1, CGRectGetHeight(selfRect)-2) byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(CGRectGetWidth(selfRect)/2, CGRectGetWidth(selfRect)/2)];
        [rectangle2Path closePath];
        [Color_White setFill];
        [rectangle2Path fill];
        [Color_Main setStroke];
        rectangle2Path.lineWidth = 1.5;
        [rectangle2Path stroke];
    } else {
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetWidth(selfRect)/2, 0, CGRectGetWidth(selfRect)/2, CGRectGetHeight(selfRect)) byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(CGRectGetWidth(selfRect)/2, CGRectGetWidth(selfRect)/2)];
        [rectanglePath closePath];
        [Color_Main setFill];
        [rectanglePath fill];
        
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1, 1, CGRectGetWidth(selfRect)/2-1, CGRectGetHeight(selfRect)-2) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(CGRectGetWidth(selfRect)/2, CGRectGetWidth(selfRect)/2)];
        [rectangle2Path closePath];
        [Color_White setFill];
        [rectangle2Path fill];
        [Color_Main setStroke];
        rectangle2Path.lineWidth = 1.5;
        [rectangle2Path stroke];
        
    }
    
    
}


@end
