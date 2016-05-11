//
//  ViewController.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-8.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "ViewController.h"
#import "RFActivityDetailViewController.h"
#import "RFAlertView.h"
#import "LayoutViewController.h"
#import "RFTermsAlertView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"入口";
    self.dataSource=@[@"活动详情",@"Alert",@"Layout"];
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=[self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            RFActivityDetailViewController *vc=[RFActivityDetailViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            RFTermsAlertView *alert=[[RFTermsAlertView alloc] initWithTerms:@"鉴于Android的进程内存限制，捕获的图片不要超过1024*1024，建议为640*640以下；同时，宽和高必须为4的倍数。"];
            alert.handleActionBlock=^(BOOL cancel){
                if (cancel) {
                    RFLog(@"cancel");
                } else {
                    RFLog(@"ok");
                }
            };
            [alert showInView:self.navigationController.view];
        }
            break;
        case 2:
        {
            LayoutViewController *vc=[LayoutViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
