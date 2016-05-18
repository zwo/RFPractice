//
//  RFCountdownCellViewController.m
//  RFPractice
//
//  Created by zhouweiou on 16/5/18.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFCountdownCellViewController.h"
#import "RFCountDownTableViewCell.h"
#import "RFHomeTimer.h"
#import "LayoutViewController.h"

@interface RFCountdownCellViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation RFCountdownCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"倒计时";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[RFHomeTimer sharedInstance] resume];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[RFHomeTimer sharedInstance] pause];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[UITableView new];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.rowHeight=40;
    }
    return _tableView;
}

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
    RFCountDownTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[RFCountDownTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [[RFHomeTimer sharedInstance] addDelegate:cell delegateQueue:NULL];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutViewController *vc=[LayoutViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
