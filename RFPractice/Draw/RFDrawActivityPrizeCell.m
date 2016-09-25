#import "RFDrawActivityPrizeCell.h"

static CGFloat kLabelWidth=64;
static CGFloat kLabelHeight=20;

@interface RFDrawActivityPrizeDetailCell ()
@property (nonatomic,strong) UIView *labelsContainer;
@end

@implementation RFDrawActivityPrizeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;        
    }
    return self;
}

- (void)setupUIWithArray:(NSArray *)array
{
	NSInteger totalCount=[array count];
	if (totalCount == 0)
	{
		return;
	}
	if (self.labelsContainer)
	{
		[self.labelsContainer removeFromSuperview];
	}
	self.labelsContainer=[[UIView alloc] initWithFrame:CGRectMake(0,0,RFSCREEN_W,ceilf(totalCount/5.0) * kLabelHeight)];
	_labelsContainer.backgroundColor = RFRGB16Color(0xf5f5f5);
	[self.contentView addSubview:_labelsContainer];

	int j=0, y=0;
	CGFloat gap = (RFSCREEN_W-kLabelWidth*5)/6;

	for (int i = 0; i < totalCount; ++i)
	{
		UILabel *label=[self generalLabel];
		label.text=array[i];
		label.frame=CGRectMake((j*(kLabelWidth+gap)+gap),y,kLabelWidth,kLabelHeight);
		[_labelsContainer addSubview:label];
		j++;
		if (j>4)
		{
			j=0;
			y += kLabelHeight;
		}
	}
}

- (UILabel *)generalLabel
{
	UILabel *label=[UILabel new];
	label.font=[UIFont systemFontOfSize:11];
	label.textColor=RFRGB16Color(0x9b9b9b);
	label.textAlignment = NSTextAlignmentCenter;
	return label;
}

+ (CGFloat)cellHeightWithItemsCount:(NSInteger)count
{
	return ceilf(count/5.0) * kLabelHeight;
}
@end



@interface RFDrawActivityPrizeHeaderCell ()
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *labelName;
@property (nonatomic,strong) UILabel *labelPhone;
@property (nonatomic,strong) UILabel *labelCity;
@property (nonatomic,strong) UILabel *labelIdentity;
@property (nonatomic,strong) UILabel *labelNumPeople;
@property (nonatomic,strong) UILabel *labelEndTime;
@property (nonatomic,strong) UILabel *labelLuckNumber;
@end

@implementation RFDrawActivityPrizeHeaderCell

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
	UIView *greyView=[UIView new];
	greyView.backgroundColor=Color_Bg;
	[self.contentView addSubview:greyView];
	[greyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.left.right.equalTo(self.contentView);
    }];

    UIImage *redBG=[[UIImage imageNamed:@"draw_img_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 28, 14, 26)];
    UIImageView *redBGView=[[UIImageView alloc] initWithImage:redBG];
    [self.contentView addSubview:redBGView];
    [redBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(111);
        make.left.right.equalTo(self.contentView);
        make.top.mas_equalTo(5);
    }];

    UILabel *labelDesc=[UILabel new];
    labelDesc.font=[UIFont systemFontOfSize:13];
	labelDesc.textColor=Color_White;
	labelDesc.text=@"获奖信息";
	[self.contentView addSubview:labelDesc];
	[labelDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(redBGView).offset(9);
    }];

    UIImageView *dashLine=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"draw_img_redline"]];
    [self.contentView addSubview:dashLine];
    [dashLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.equalTo(redBGView).offset(33);
    }];

    _avatar=[UIImageView new];
    _avatar.layer.cornerRadius=22;
    _avatar.layer.borderWidth=2;
    _avatar.layer.borderColor=Color_White.CGColor;
    [self.contentView addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44,44));
        make.left.mas_equalTo(Margin_LR);
        make.top.equalTo(dashLine.mas_bottom).offset(12);
    }];

    _labelName=[UILabel new];
    _labelName.font=[UIFont systemFontOfSize:18];
	_labelName.textColor=Color_White;
	[self.contentView addSubview:_labelName];
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(10);
        make.top.equalTo(_avatar);
    }];

    _labelPhone=[UILabel new];
    _labelPhone.font=[UIFont systemFontOfSize:12];
	_labelPhone.textColor=Color_White;
	[self.contentView addSubview:_labelPhone];
    [_labelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelName.mas_right).offset(6);
        make.bottom.equalTo(_labelName);
    }];

    _labelCity=[UILabel new];
    _labelCity.font=[UIFont systemFontOfSize:12];
	_labelCity.textColor=RFRGB16Color(0xc2e3332);
	[self.contentView addSubview:_labelCity];
    [_labelCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(10);
        make.bottom.equalTo(_avatar);
    }];

    UIButton *btnCall=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnCall setImage:[UIImage imageNamed:@"draw_btn_call"] forState:UIControlStateNormal];
    [self.contentView addSubview:btnCall];
    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(21,21));
        make.centerY.equalTo(_avatar);
    }];
    [btnCall addTarget:self action:@selector(onButtonPhone:) forControlEvents:UIControlEventTouchUpInside]; 

    UIButton *btnChat=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnChat setImage:[UIImage imageNamed:@"draw_btn_chat"] forState:UIControlStateNormal];
    [self.contentView addSubview:btnChat];
    [btnChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btnCall.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(24,21));
        make.centerY.equalTo(_avatar);
    }];
    [btnChat addTarget:self action:@selector(onButtonIM:) forControlEvents:UIControlEventTouchUpInside]; 

    _labelIdentity=[self generalLabel];
    [self.contentView addSubview:_labelIdentity];
    [_labelIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin_LR);
        make.top.equalTo(redBGView.mas_bottom).offset(8);
    }];

    _labelNumPeople=[self generalLabel];
    [self.contentView addSubview:_labelNumPeople];
    [_labelNumPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelIdentity);
        make.top.equalTo(_labelIdentity.mas_bottom).offset(8);
    }];

    _labelEndTime=[self generalLabel];
    [self.contentView addSubview:_labelEndTime];
    [_labelEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelNumPeople);
        make.top.equalTo(_labelNumPeople.mas_bottom).offset(8);
    }];

    _labelLuckNumber=[self generalLabel];
    [self.contentView addSubview:_labelLuckNumber];
    [_labelLuckNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelEndTime);
        make.top.equalTo(_labelEndTime.mas_bottom).offset(8);
    }];

    UIView *line = [UIView new];
    line.backgroundColor=RFRGB16Color(0xdcdcdc);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.equalTo(_labelLuckNumber.mas_bottom).offset(15);
    }];

    UIView *columnBG=[UIView new];
    columnBG.backgroundColor=RFRGB16Color(0xf5f5f5);
    columnBG.layer.cornerRadius=12;
    [self.contentView addSubview:columnBG];
    [columnBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.height.mas_equalTo(24);
        make.bottom.equalTo(self.contentView);
    }];

    UIView *columnContainer=[UIView new];
    [self.contentView addSubview:columnContainer];
    [columnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(24);
        make.bottom.equalTo(self.contentView);
    }];

    [self addColumnWithTitle:@"时间" width:80 ratio:38/720.0 container:columnContainer];
    [self addColumnWithTitle:@"次数" width:34 ratio:214/720.0 container:columnContainer];
    [self addColumnWithTitle:@"金额" width:62 ratio:309/720.0 container:columnContainer];
    [self addColumnWithTitle:@"状态" width:45 ratio:472/720.0 container:columnContainer];
    [self addColumnWithTitle:@"号码" width:40 ratio:589/720.0 container:columnContainer];

    //test
    _avatar.image=[UIImage imageNamed:@"draw_btn_more@"];
    _labelName.text=@"廖先生";
    _labelPhone.text=@"13800138000";
    _labelCity.text=@"北京";
    _labelIdentity.text=@"123124123";
    _labelNumPeople.text=@"20";
    _labelEndTime.text=@"2016-12-14 12:55:55";
    _labelLuckNumber.text=@"234234";
}

- (void)addColumnWithTitle:(NSString *)title width:(CGFloat)width ratio:(CGFloat)ratio container:(UIView *)container
{
	UILabel *label=[UILabel new];
	label.font=[UIFont systemFontOfSize:12];
	label.textColor=RFRGB16Color(0x9b9b9b);
	label.textAlignment = NSTextAlignmentCenter;
	label.frame=CGRectMake(RFSCREEN_W*ratio,0,width,24);
	label.text=title;
	[container addSubview:label];
}

- (UILabel *)generalLabel
{
	UILabel *label=[UILabel new];
	label.font=[UIFont systemFontOfSize:13];
	label.textColor=RFRGB16Color(0x9b9b9b);
	label.textAlignment = NSTextAlignmentCenter;
	return label;
}

- (void)onButtonIM:(id)sender
{
	if (self.handleIMBlock)
	{
		self.handleIMBlock();
	}
}

- (void)onButtonPhone:(id)sender
{
	if (self.handlePhoneBlock)
	{
		self.handlePhoneBlock();
	}
}

+ (CGFloat)cellHeight
{
	return 250;
}
@end

static CGFloat kPrizeCellHeight = 45;

@interface RFDrawActivityPrizeCell ()
@property (nonatomic,strong) UIImageView *dashLine;
@property (nonatomic,strong) UILabel *labelDate;
@property (nonatomic,strong) UILabel *labelTime;
@property (nonatomic,strong) UILabel *labelNumber;
@property (nonatomic,strong) UILabel *labelCost;
@property (nonatomic,strong) UILabel *labelStatus;
@property (nonatomic,strong) UIButton *buttonFold;
@property (nonatomic,assign) BOOL isFold;
@end

@implementation RFDrawActivityPrizeCell

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

	CGFloat screenWidth=RFSCREEN_W;

	_dashLine=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"draw_dashline"]];
	[self.contentView addSubview:_dashLine];
	[_dashLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(8);
        make.height.mas_equalTo(1);
    }];

    UIView *firstColumnContainer=[UIView new];
    firstColumnContainer.frame=CGRectMake(38/720.0*screenWidth,0,80,kPrizeCellHeight);
    [self.contentView addSubview:firstColumnContainer];
    _labelDate=[self generalLabel];
    [firstColumnContainer addSubview:_labelDate];
    [_labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(firstColumnContainer);
        make.bottom.equalTo(firstColumnContainer.mas_top).offset(kPrizeCellHeight/2);
    }];
    _labelTime=[self generalLabel];
    [firstColumnContainer addSubview:_labelTime];
    [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_labelDate);
        make.top.equalTo(_labelDate.mas_bottom);
    }];

    _labelNumber=[self generalLabel];
    _labelNumber.frame=CGRectMake(214/720.0*screenWidth,0,34,kPrizeCellHeight);
    [self.contentView addSubview:_labelNumber];

    _labelCost=[self generalLabel];
    _labelCost.frame=CGRectMake(309/720.0*screenWidth,0,62,kPrizeCellHeight);
    [self.contentView addSubview:_labelCost];

    _labelStatus=[self generalLabel];
    _labelStatus.frame=CGRectMake(472/720.0*screenWidth,0,45,kPrizeCellHeight);
    [self.contentView addSubview:_labelStatus];

    _buttonFold=[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonFold setImage:[UIImage imageNamed:@"draw_btn_more"] forState:UIControlStateNormal];
    [_buttonFold addTarget:self action:@selector(onButtonFold:) forControlEvents:UIControlEventTouchUpInside]; 
    _buttonFold.frame=CGRectMake(589/720.0*screenWidth,0,40,kPrizeCellHeight);
    
    _labelDate.text=@"2016-08-11";
    _labelTime.text=@"18:18:11";
    _labelNumber.text=@"3";
    _labelCost.text=@"￥4000";
    _labelStatus.text=@"待支付";
}

- (UILabel *)generalLabel
{
	UILabel *label=[UILabel new];
	label.font=[UIFont systemFontOfSize:13];
	label.textColor=RFRGB16Color(0x9b9b9b);
	label.textAlignment = NSTextAlignmentCenter;
	return label;
}

- (void)hideDashLine:(BOOL)hide;
{
	if (hide)
	{
		_dashLine.hidden=true;
	}else{
		_dashLine.hidden=false;
	}
}

- (void)onButtonFold:(id)sender
{

}

+ (CGFloat)cellHeight
{
	return kPrizeCellHeight;
}
@end