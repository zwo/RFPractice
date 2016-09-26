#import "RFActivityDrawViewController.h"
#import "RFHomeTimer.h"
#import "RFDrawActivityPrizeCell.h"


typedef NS_ENUM(NSInteger, RFDrawActivityState) {
    RFDrawActivityStateEndNotFull,//默认从0开始,已开奖
    RFDrawActivityStatePrize,//未满，结束，提示退款
    RFDrawActivityStateNotStart,//未开始，显示倒计时
    RFDrawActivityStateStartFull,//开始，已满，显示倒计时
    RFDrawActivityStateStartNotFull,//开始未满，显示进度
};

static NSString * kPrizeCellID=@"kPrizeCellID";
static NSString * kPrizeCellHeadID=@"kPrizeCellHeadID";
static NSString * kPrizeCellDetailID=@"kPrizeCellDetailID";

@interface RFActivityDrawViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSString *act_id;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) RFDrawActivityState *drawState;

/** table header */
//banner
/** 添加页码 */
@property (nonatomic, strong) UILabel *cycleScrollPageLable;
/** 幻灯图片列表 */
@property (nonatomic, strong) NSMutableArray *imagesURLArray;
@end

@implementation RFActivityDrawViewController

- (instancetype)initWithActID:(NSString *)act_id
{
    self=[super init];
    if (self) {
        self.act_id=act_id;        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [[RFHomeTimer sharedInstance] resume];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[RFHomeTimer sharedInstance] pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"众筹活动详情";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -- 懒加载
- (NSMutableArray *)imagesURLArray
{
    if (!_imagesURLArray) {
        _imagesURLArray = [NSMutableArray array];
    }
    return _imagesURLArray;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[UITableView new];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[self footerView];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=Color_Bg; 
        _tableView.tableHeaderView=[self headerView];       
        [_tableView registerClass:[RFDrawActivityPrizeCell class] forCellReuseIdentifier:kPrizeCellID];
        [_tableView registerClass:[RFDrawActivityPrizeHeaderCell class] forCellReuseIdentifier:kPrizeCellHeadID];
        [_tableView registerClass:[RFDrawActivityPrizeDetailCell class] forCellReuseIdentifier:kPrizeCellDetailID];
    }
    return _tableView;
}

//头部
- (UIView *)headerView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = Color_Bg;
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    /*
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, RFSCREEN_W, RFSCREEN_W * 0.6) delegate:self placeholderImage:[UIImage imageNamed:@"house_loading.jpg"]];
    cycleScrollView.imageURLStringsGroup = _imagesURLArray;
    cycleScrollView.showPageControl = NO;//不显示分页点
    cycleScrollView.autoScroll = YES;
    cycleScrollView.autoScrollTimeInterval=5.0f;
    cycleScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
    [headerView addSubview:cycleScrollView];
    
    // 添加cycleScrollView 页码
    UILabel *cycleScrollPageLable = [[UILabel alloc] initWithFrame:CGRectMake(RFSCREEN_W - 60, RFSCREEN_W * 0.6 - 40 + 48, 50, 30)];
    cycleScrollPageLable.layer.cornerRadius = 3;
    cycleScrollPageLable.layer.masksToBounds = YES;
    cycleScrollPageLable.backgroundColor = RFRGBAColor(5, 5, 5, 0.5);
    cycleScrollPageLable.font = Font_Standard;
    cycleScrollPageLable.textColor = Color_White;
    cycleScrollPageLable.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_imagesURLArray.count];
    cycleScrollPageLable.textAlignment = NSTextAlignmentCenter;
    self.cycleScrollPageLable = cycleScrollPageLable;
    [headerView addSubview:cycleScrollPageLable];
    */
    UIView *cycleScrollView=[UIView new];
    cycleScrollView.backgroundColor=[UIColor redColor];
    cycleScrollView.frame=CGRectMake(0, 0, RFSCREEN_W, RFSCREEN_W * 0.6);
    [headerView addSubview:cycleScrollView];
    
    
    //活动信息
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), RFSCREEN_W, 105)];
    titleView.backgroundColor = Color_White;
    [headerView addSubview:titleView];
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = Font_A3;
    titleLab.numberOfLines = 2;
    titleLab.text = @"广州富力东山新天地D8-1208广州富力东山新天地D8-1208广州富力东山新天地D8-1208";
    titleLab.textColor = Color_Content;
    [titleView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin_LR);
        make.right.equalTo(titleView);
        make.top.mas_equalTo(12);
    }];   
    
    UILabel *subTitleLab = [UILabel new];
    subTitleLab.font = Font_Standard;
    subTitleLab.textColor = Color_Desc;
    subTitleLab.text = @"广州富力东山新天地D8-1208";
    [titleView addSubview:subTitleLab];
    [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin_LR);
        make.right.equalTo(titleView);
        make.top.equalTo(titleLab.mas_bottom).offset(6);
    }];   

    UILabel *costPerPortionLabel=[UILabel new];
    costPerPortionLabel.font=[UIFont systemFontOfSize:15];
    costPerPortionLabel.textColor=RFRGB16Color(0xf86461);
    costPerPortionLabel.text=@"单份金额：￥200";
    [titleView addSubview:costPerPortionLabel];
    [costPerPortionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin_LR);
        make.top.equalTo(subTitleLab.mas_bottom).offset(8);
    }];

    UILabel *endTime=[UILabel new];
    endTime.font=[UIFont systemFontOfSize:13];
    endTime.textColor=Color_Desc;
    endTime.text=@"时间至2016.9.20";
    [titleView addSubview:endTime];
    [endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleView).offset(-Margin_LR);
        make.centerY.equalTo(costPerPortionLabel);
    }];

    UIImageView *timeIcon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"draw_icon_time"]];
    [titleView addSubview:timeIcon];
    [timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12,12));
        make.centerY.equalTo(endTime);
        make.right.equalTo(endTime.mas_left).offset(-3);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RFRGB16Color(0xf0f0f0);
    [titleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.left.bottom.equalTo(titleView);
    }];    
    
    CGFloat headerViewH = CGRectGetMaxY(titleView.frame);

    headerView.frame = CGRectMake(0, 0, RFSCREEN_W, headerViewH);
    return headerView;

}

- (UIView *)footerView{
	UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0,0,RFSCREEN_W,75)];
	footerView.backgroundColor=Color_Bg;
	UIView *container=[[UIView alloc] initWithFrame:CGRectMake(0,5,RFSCREEN_W,70)];
	container.backgroundColor=Color_White;
	[footerView addSubview:container];
	UIImageView *icon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"draw_ico_intro"]];
	[container addSubview:icon];
	[icon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(18,21));
        make.centerY.equalTo(container);
        make.left.mas_equalTo(Margin_LR);
    }];
    UILabel *label=[UILabel new];
    label.font=[UIFont systemFontOfSize:19];
    label.textColor=Color_Content;
    label.text=@"商品介绍";
    [container addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.centerY.equalTo(icon);
    }];

    UILabel *dot=[UILabel new];
    dot.font=[UIFont systemFontOfSize:11];
    dot.textColor=Color_Desc;
    dot.text=@"┅";
    [container addSubview:dot];
    [dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(container).offset(-5);
        make.centerY.equalTo(icon);
    }];

    UIButton *detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame=container.frame;
    [footerView addSubview:detailBtn];
    [detailBtn addTarget:self action:@selector(onButtonShowItemDetail:) forControlEvents:UIControlEventTouchUpInside];  

    return footerView;
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    UITableViewCell *cell;
    switch (row) {
        case 0:
            cell=[tableView dequeueReusableCellWithIdentifier:kPrizeCellHeadID forIndexPath:indexPath];
            break;
        case 1:
            cell=[tableView dequeueReusableCellWithIdentifier:kPrizeCellID forIndexPath:indexPath];
            break;
        case 2:
        {
            cell=[tableView dequeueReusableCellWithIdentifier:kPrizeCellDetailID forIndexPath:indexPath];
            [(RFDrawActivityPrizeDetailCell*)cell setupUIWithArray:@[@"111231"]];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    CGFloat height=0;
    switch (row) {
        case 0:
            height=[RFDrawActivityPrizeHeaderCell cellHeight];
            break;
        case 1:
            height=[RFDrawActivityPrizeCell cellHeight];
            break;
        case 2:
            height=[RFDrawActivityPrizeDetailCell cellHeightWithItemsCount:1];
            break;
        default:
            break;
    }
    return height;
}

#pragma mark - Action

- (void)onButtonShowItemDetail:(id)sender
{

}

@end