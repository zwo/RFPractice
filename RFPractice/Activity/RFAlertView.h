//
//  RFAlertView.h
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-8.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RFAlertViewHandleActionBlock)(BOOL cancel);

@interface RFAlertView : UIView
@property (nonatomic,copy) RFAlertViewHandleActionBlock handleActionBlock;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle;

- (void)showInView:(UIView *)view;

@end
