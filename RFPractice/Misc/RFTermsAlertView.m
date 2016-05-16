//
//  RFTermsAlertView.m
//  RFPractice
//
//  Created by zwo on 16/5/11.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFTermsAlertView.h"
#import "CTCheckbox.h"
#import "NSString+Size.h"

@interface RFTermsAlertView ()
@property (nonatomic,copy) NSString *terms;
@property (nonatomic,strong) CTCheckbox *checkbox;
@end

@implementation RFTermsAlertView

- (instancetype)initWithTerms:(NSString *)terms
{
    self=[super initWithFrame:CGRectZero];
    if (self) {
        self.terms=terms;
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
    
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 370));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(60);
    }];
    
    UILabel *titleLabel=[UILabel new];
    titleLabel.text=@"预订须知";
    titleLabel.font=Font_A2;
    titleLabel.textColor=Color_Main;
    [containerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView);
        make.top.mas_equalTo(16);
    }];
    
    UIView *decorLine=[UIView new];
    decorLine.backgroundColor=RFRGB16Color(0xf1f1f1);
    [containerView addSubview:decorLine];
    [decorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(titleLabel.mas_bottom).offset(16);
        make.left.right.equalTo(containerView);
    }];
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(12, 60, 256, 225)];
    [containerView addSubview:scrollView];
    UILabel *textLabel=[UILabel new];
    textLabel.numberOfLines=0;
    textLabel.textColor=Color_Desc;
    textLabel.font=Font_Big;
    textLabel.text=self.terms;
    
    CGSize textSize=[self.terms sizeMakeWithFont:Font_Big maxW:256];
    textLabel.frame=CGRectMake(0, 0, 256, textSize.height+2);
    [scrollView addSubview:textLabel];
    scrollView.contentSize=CGSizeMake(256, textSize.height+2);
    
//    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(12, 60, 256, 225)];
//    textView.editable=NO;
//    textView.textColor=Color_Desc;
//    textView.font=Font_Big;
//    textView.text=self.terms;
//    
//    [containerView addSubview:textView];
    
    self.checkbox=[[CTCheckbox alloc] initWithFrame:CGRectMake(12, 294, 200, 16)];
    [containerView addSubview:self.checkbox];
    _checkbox.checkboxSideLength=16.0;
    _checkbox.checkboxColor=Color_Content;
    _checkbox.textLabel.textColor=Color_Content;
    _checkbox.textLabel.font=Font_Small;
    _checkbox.textLabel.text=@"我已阅读并同意以上条款的所有内容";
    
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor=Color_White;
    cancelButton.layer.borderColor=Color_Main.CGColor;
    cancelButton.layer.borderWidth=1;
    [cancelButton addTarget:self action:@selector(onButtonCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:Color_Main forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font=Font_Big;
    [containerView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 32));
        make.left.mas_equalTo(18);
        make.top.equalTo(decorLine.mas_bottom).offset(266);
    }];
    
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    okButton.backgroundColor=Color_White;
    okButton.layer.borderColor=Color_Main.CGColor;
    okButton.layer.borderWidth=1;
    [okButton addTarget:self action:@selector(onButtonOK) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitleColor:Color_Main forState:UIControlStateNormal];
    [okButton setTitle:@"同意" forState:UIControlStateNormal];
    okButton.titleLabel.font=Font_Big;
    [containerView addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 32));
        make.right.equalTo(containerView).offset(-18);
        make.top.equalTo(decorLine.mas_bottom).offset(266);
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
