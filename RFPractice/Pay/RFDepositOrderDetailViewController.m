//
//  RFDepositOrderDetailViewController.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-15.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "RFDepositOrderDetailViewController.h"

#define kCountdownLabelWidth 22

@interface RFDepositOrderDetailViewController ()
@property (nonatomic,assign) BOOL isChannelUser;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *hourLabel;
@property (nonatomic,strong) UILabel *minuteLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *houseCellContainer;
@property (nonatomic,strong) UIView *infoContainer;
@property (nonatomic,strong) UIView *progressContainer;
@property (nonatomic,strong) UIView *contactContainer;
@property (nonatomic,strong) UIButton *buttonPay;

@property (nonatomic,assign) NSTimeInterval expireTimeInterval;
@end

@implementation RFDepositOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"订单详情";
    _scrollView=[UIScrollView new];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor=Color_Bg;
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _houseCellContainer=[UIView new];
    _houseCellContainer.frame=CGRectMake(0, 0, RFSCREEN_W, 110);
    _houseCellContainer.backgroundColor=Color_White;
    [_scrollView addSubview:_houseCellContainer];
    _scrollView.contentSize=CGSizeMake(RFSCREEN_W, 110);
    [self setupUI];
}

- (void)setupUI
{
    _infoContainer=[UIView new];
    _infoContainer.backgroundColor=Color_White;
    [_scrollView addSubview:_infoContainer];
    _infoContainer.frame=CGRectMake(0, CGRectGetMaxY(_houseCellContainer.frame)+10, RFSCREEN_W, 365);
    
    [self setupCountdownLabel];
    
    _buttonPay=[UIButton buttonWithType:UIButtonTypeCustom];
    _buttonPay.backgroundColor=Color_Main;
    [_buttonPay setTitleColor:Color_White forState:UIControlStateNormal];
    [_buttonPay setTitle:@"立即支付" forState:UIControlStateNormal];
    [_buttonPay addTarget:self action:@selector(onButtonPay) forControlEvents:UIControlEventTouchUpInside];
    _buttonPay.titleLabel.font=Font_Standard;
    [_scrollView addSubview:_buttonPay];
    _buttonPay.frame=CGRectMake(0, CGRectGetMaxY(_infoContainer.frame)+10, RFSCREEN_W, 44);
    _scrollView.contentSize=CGSizeMake(RFSCREEN_W, CGRectGetMaxY(_buttonPay.frame)+20);
    
    [self startTimer];
}

- (void)setupUI2
{
    _infoContainer=[UIView new];
    _infoContainer.backgroundColor=Color_White;
    [_scrollView addSubview:_infoContainer];
    _infoContainer.frame=CGRectMake(0, CGRectGetMaxY(_houseCellContainer.frame)+10, RFSCREEN_W, 365);
    
    [self setupCountdownLabel];
    _scrollView.contentSize=CGSizeMake(RFSCREEN_W, CGRectGetMaxY(_infoContainer.frame)+20);
}

- (void)setupCountdownLabel
{
    _secondLabel=[self countdownLabel];
    [_infoContainer addSubview:_secondLabel];
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.equalTo(_infoContainer).offset(-12);
        make.size.mas_equalTo(CGSizeMake(kCountdownLabelWidth, kCountdownLabelWidth));
    }];
    
    UILabel *separator=[self countdownLabelSeparator];
    [_infoContainer addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondLabel.mas_left);
        make.centerY.equalTo(_secondLabel);
    }];
    
    _minuteLabel=[self countdownLabel];
    [_infoContainer addSubview:_minuteLabel];
    [_minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.equalTo(_secondLabel.mas_left).offset(-6);
        make.size.mas_equalTo(CGSizeMake(kCountdownLabelWidth, kCountdownLabelWidth));
    }];
    
    separator=[self countdownLabelSeparator];
    [_infoContainer addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_minuteLabel.mas_left);
        make.centerY.equalTo(_minuteLabel);
    }];
    
    _hourLabel=[self countdownLabel];
    [_infoContainer addSubview:_hourLabel];
    [_hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.equalTo(_minuteLabel.mas_left).offset(-6);
        make.size.mas_equalTo(CGSizeMake(kCountdownLabelWidth, kCountdownLabelWidth));
    }];
    
    UILabel *label1=[UILabel new];
    label1.text=_isChannelUser?@"线下交易":@"在线支付";
    label1.font=[UIFont systemFontOfSize:10];
    label1.textColor=Color_Desc;
    [_infoContainer addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hourLabel);
        make.right.equalTo(_hourLabel.mas_left).offset(-3);
    }];
    
    UILabel *label2=[UILabel new];
    label2.text=@"有效时间";
    label2.font=[UIFont systemFontOfSize:10];
    label2.textColor=Color_Desc;
    [_infoContainer addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_hourLabel);
        make.right.equalTo(_hourLabel.mas_left).offset(-3);
    }];
}

- (UILabel *)countdownLabel
{
    UILabel *label=[UILabel new];
    label.backgroundColor=RFRGB16Color(0xff6060);
    label.textColor=Color_White;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=Font_Standard;
    label.text=@"00";
    return label;
}

- (UILabel *)countdownLabelSeparator
{
    UILabel *label=[UILabel new];
    label.font=Font_Standard;
    label.textColor=RFRGB16Color(0xff6060);
    label.text=@":";
    return label;
}

#pragma mark Actions

- (void)startTimer
{
    NSDateFormatter *fmt=[NSDateFormatter new];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    
    NSDate *expireDate=[fmt dateFromString:@"2016-5-15 16:00:00"];
    _expireTimeInterval=[expireDate timeIntervalSince1970];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)onButtonPay
{
    [self removeAllViews];
    [self setupUI2];
}

- (void)removeAllViews
{
    [_hourLabel removeFromSuperview]; _hourLabel = nil;
    [_minuteLabel removeFromSuperview]; _minuteLabel = nil;
    [_secondLabel removeFromSuperview]; _secondLabel = nil;
    [_infoContainer removeFromSuperview]; _infoContainer = nil;
    [_progressContainer removeFromSuperview]; _progressContainer = nil;
    [_contactContainer removeFromSuperview]; _contactContainer = nil;
    [_buttonPay removeFromSuperview]; _buttonPay = nil;
}

- (void)onTimer:(NSTimer *)timer
{
    NSTimeInterval now=[[NSDate date] timeIntervalSince1970];
    NSTimeInterval diff=_expireTimeInterval-now;
    if (diff>0) {
        int second = (int)diff  % 60;
        int minute = ((int)diff / 60) % 60;
        int hours = diff / 3600;
        _hourLabel.text=[NSString stringWithFormat:@"%02d",hours];
        _minuteLabel.text=[NSString stringWithFormat:@"%02d",minute];
        _secondLabel.text=[NSString stringWithFormat:@"%02d",second];
    } else {
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        _hourLabel.text = @"00";
        _minuteLabel.text = @"00";
        _secondLabel.text = @"00";
        [self onOrderExpirationTime];
    }
}

- (void)onOrderExpirationTime
{
    RFLog(@"onOrderExpirationTime");
}

@end
