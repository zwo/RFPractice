//
//  RFActivityDetailCouponCell.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-8.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "RFActivityDetailCouponCell.h"

#pragma mark - RFActivityDetailCouponCell

@implementation RFActivityDetailCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor=Color_White;
    UIView *containerView=[UIView new];
    containerView.backgroundColor=Color_White;
    [self.contentView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insects=UIEdgeInsetsMake(8, 12, 8, 12);
        make.edges.equalTo(self.contentView).with.insets(insects);
    }];
    containerView.layer.borderColor=Color_Bg.CGColor;
    containerView.layer.borderWidth=1.0;
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth=1.0;
    button.layer.borderColor=Color_Main.CGColor;
    [button setTitleColor:Color_Main forState:UIControlStateNormal];
    [button setTitle:@"领 取" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonGet) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.top.mas_equalTo(20);
        make.right.equalTo(containerView).offset(-4);
    }];
}

- (void)onButtonGet
{
    if (self.handleActionBlock) {
        self.handleActionBlock(self.indexPath);
    }
}

@end

#pragma mark - RFActivityDetailContactCell

@implementation RFActivityDetailContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor=Color_Bg;
    UIView *containerView=[UIView new];
    containerView.backgroundColor=Color_White;
    [self.contentView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insects=UIEdgeInsetsMake(8, 0, 0, 0);
        make.edges.equalTo(self.contentView).with.insets(insects);
    }];
}

- (void)onButtonCall
{
    if (self.handleActionBlock) {
        self.handleActionBlock(nil);
    }
}

@end

#pragma mark - RFActivityDetailDescriptionCell

@implementation RFActivityDetailDescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIView *containerView=[UIView new];
    containerView.backgroundColor=Color_White;
    [self.contentView addSubview:containerView];
    
    UILabel *label=[UILabel new];
    label.numberOfLines=0;
    label.font=Font_Small;
    label.textColor=Color_Title;
    [containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.equalTo(containerView).offset(-12);
        make.top.mas_equalTo(8);
    }];
    self.descritpionLabel=label;
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.equalTo(label.mas_bottom).offset(8);
    }];
    
    UIView *view=[UIView new];
    view.backgroundColor=Color_Bg;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(containerView.mas_bottom);
        make.height.mas_equalTo(35);
    }];
    self.bottomView=view;
}

- (void)setDescriptionString:(NSString *)descriptionString
{
    self.descritpionLabel.text=descriptionString;
}

- (CGFloat)cellHeight
{
    CGRect frame=self.frame;
    frame.size.width=RFSCREEN_W;
    self.frame=frame;
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.bottomView.frame);
}

@end
