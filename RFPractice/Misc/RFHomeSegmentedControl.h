//
//  RFHomeSegmentedControl.h
//  RFPractice
//
//  Created by zwo on 16/5/10.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleSelectBlock)(NSInteger selectedIndex);

@interface RFHomeSegmentedControl : UIView

@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,copy) HandleSelectBlock handleSelectBlock;

- (instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

- (void)setLeftTitle:(NSString *)title;
- (void)setRightTitle:(NSString *)title;

@end
