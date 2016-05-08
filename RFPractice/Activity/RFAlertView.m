//
//  RFAlertView.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-8.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "RFAlertView.h"

@interface RFAlertView ()
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *cancelTitle;
@property (nonatomic,copy) NSString *okTitle;
@end

@implementation RFAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle
{
    self=[super initWithFrame:CGRectZero];
    if (self) {
        self.title=title;
        self.message=message;
        self.cancelTitle=cancelTitle;
        self.okTitle=okTitle;
    }
    return self;
}

- (void)showInView:(UIView *)superview
{
    if (!superview) {
        return;
    }
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [superview addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
    
    UIView *containerView=[UIView new];
    containerView.backgroundColor=Color_White;
    containerView.layer.cornerRadius=5.f;
    
    UILabel *titleLabel=[UILabel new];
    titleLabel.text=self.title?:@"提示";
    titleLabel.font=Font_A2;
    titleLabel.textColor=Color_Main;
    [containerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView);
        make.top.mas_equalTo(18);
    }];
    
    UILabel *messageLabel=[UILabel new];
    messageLabel.text=self.message;
    messageLabel.font=Font_Big;
    messageLabel.textColor=Color_Desc;
    messageLabel.numberOfLines=0;
    [containerView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(58);
        make.left.mas_equalTo(18);
        make.right.equalTo(containerView).offset(-18);
    }];
    
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor=Color_White;
    cancelButton.layer.borderColor=Color_Main.CGColor;
    cancelButton.layer.borderWidth=1;
    [cancelButton addTarget:self action:@selector(onButtonCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:Color_Main forState:UIControlStateNormal];
    [cancelButton setTitle:self.cancelTitle?:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font=Font_Big;
    [containerView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 32));
        make.left.mas_equalTo(18);
        make.top.equalTo(messageLabel.mas_bottom).offset(18);
    }];
    
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    okButton.backgroundColor=Color_White;
    okButton.layer.borderColor=Color_Main.CGColor;
    okButton.layer.borderWidth=1;
    [okButton addTarget:self action:@selector(onButtonOK) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitleColor:Color_Main forState:UIControlStateNormal];
    [okButton setTitle:self.okTitle?:@"确定" forState:UIControlStateNormal];
    okButton.titleLabel.font=Font_Big;
    [containerView addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 32));
        make.right.equalTo(containerView).offset(-18);
        make.top.equalTo(messageLabel.mas_bottom).offset(18);
    }];
    
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(280);
        make.center.equalTo(self);
        make.bottom.equalTo(okButton.mas_bottom).offset(18);
    }];
}

- (void)onButtonCancel
{
    if (self.handleActionBlock) {
        self.handleActionBlock(YES);
    }
    [self removeFromSuperview];
}

- (void)onButtonOK
{
    if (self.handleActionBlock) {
        self.handleActionBlock(NO);
    }
    [self removeFromSuperview];
}

@end
