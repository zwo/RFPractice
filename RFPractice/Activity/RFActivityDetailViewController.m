//
//  RFActivityDetailViewController.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-8.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "RFActivityDetailViewController.h"
#import "RFActivityDetailCouponCell.h"

@interface RFActivityDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSObject *model;
@property (nonatomic) CGFloat descriptionCellHeight;
@end

@implementation RFActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"活动详情";
    self.model=[NSObject new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[UITableView new];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=Color_Bg;
        CGFloat dummyViewHeight=48;
        UIView *dummyView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, RFSCREEN_W, dummyViewHeight)];
        _tableView.tableHeaderView=dummyView;
        _tableView.contentInset=UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0);
    }
    return _tableView;
}

#pragma mark - Tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.model) {
        return 4;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.model) {
        return 0;
    }
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;//礼品券个数
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    if (section==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[self cellIDForSection:section]];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIDForSection:section]];
            cell.textLabel.font=Font_Standard;
            cell.textLabel.textColor=Color_Title;
        }
        if (indexPath.row==0) {
            cell.textLabel.text=@"活动时间：2016-04-29";
        } else {
            cell.textLabel.text=@"活动地点：广州";
        }
        return cell;
    }else if (section==1) {
        RFActivityDetailCouponCell *cell=[tableView dequeueReusableCellWithIdentifier:[self cellIDForSection:section]];
        if (!cell) {
            cell=[[RFActivityDetailCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIDForSection:section]];
        }
        cell.handleActionBlock=^(NSIndexPath *aIndexPath){
            RFLog(@"button action get");
        };
        return cell;
    }else if (section==2) {
        RFActivityDetailContactCell *cell=[tableView dequeueReusableCellWithIdentifier:[self cellIDForSection:section]];
        if (!cell) {
            cell=[[RFActivityDetailContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIDForSection:section]];
        }
        cell.handleActionBlock=^(NSIndexPath *aIndexPath){
            RFLog(@"button action call");
        };
        return cell;
    }else if (section==3) {
        RFActivityDetailDescriptionCell *cell=[tableView dequeueReusableCellWithIdentifier:[self cellIDForSection:section]];
        if (!cell) {
            cell=[[RFActivityDetailDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIDForSection:section]];
        }
        cell.descriptionString=[self testString];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 0;
    } else {
        return 48;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return nil;
    } else {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, RFSCREEN_W, 48)];
        view.backgroundColor=Color_Bg;
        UIView *container=[[UIView alloc] initWithFrame:CGRectMake(0, 8, RFSCREEN_W, 40)];
        container.backgroundColor=Color_White;
        [view addSubview:container];
        UILabel *label=[UILabel new];
        label.font=Font_Big;
        label.textColor=Color_Title;
        switch (section) {
            case 0:
                label.text=@"活动信息";
                break;
            case 1:
                label.text=@"礼品卡券";
                break;
            case 3:
                label.text=@"活动说明";
                break;
            default:
                break;
        }
        [container addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(container).offset(7);
            make.centerY.equalTo(container);
        }];
        UIView *decorLine=[UIView new];
        decorLine.backgroundColor=Color_Bg;
        [container addSubview:decorLine];
        [decorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(container);
            make.height.mas_equalTo(1);
        }];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    switch (section) {
        case 0:
            return 45;
            break;
        case 1:
            return 108;
            break;
        case 2:
            return 62;
            break;
        case 3:
        {
            if (_descriptionCellHeight<1) {
                RFActivityDetailDescriptionCell *cell=[[RFActivityDetailDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIDForSection:section]];
                cell.descriptionString=[self testString];
                _descriptionCellHeight=[cell cellHeight];
            }
            return _descriptionCellHeight;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)cellIDForSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"cell%ld",(long)section];
}

- (NSString *)testString
{
    return @"The completion handler is called while the SLComposeViewController is still visible and it is responsible for dismissing the view controller. For the possible values of the result parameter, see SLComposeViewControllerResult. Use the completionHandler property to set this handler.";
}

@end
