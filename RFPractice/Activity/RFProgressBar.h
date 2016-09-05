//
//  RFProgressBar.h
//  RFPractice
//
//  Created by zhouweiou on 16/9/5.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFProgressBar : UIView

@property (strong, nonatomic) UIColor *leftEndColor;
@property (strong, nonatomic) UIColor *rightEndColor;
@property (assign, nonatomic) CGFloat percentage;

@end
