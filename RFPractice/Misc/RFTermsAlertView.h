//
//  RFTermsAlertView.h
//  RFPractice
//
//  Created by zwo on 16/5/11.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RFTermsAlertViewHandleActionBlock)(BOOL cancel);

@interface RFTermsAlertView : UIView
@property (nonatomic,copy) RFTermsAlertViewHandleActionBlock handleActionBlock;

- (instancetype)initWithTerms:(NSString *)terms;
- (void)showInView:(UIView *)view;

@end
