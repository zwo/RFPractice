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
            RFTermsAlertView *alert=[[RFTermsAlertView alloc] initWithTerms:@"相比中国对于进口的需求，国际市场向中国出口猪肉的需求则显得更为强烈。业内人士指出，国际上大多数国家生猪供应处于偏宽松的状态，猪肉价格水平不高，无论欧洲国家还是美国或加拿大，他们都希望通过打开中国市场来消耗自家的过剩猪肉产量并提高国内生猪养殖的利润。此前，美国、加拿大猪肉存在瘦肉精问题，通过多方努力，积极配合中国瘦肉精的检疫条款，才得以获得向中国出口的许可。日前，路透社报道称，中国猪肉进口的增长将有利于美国、德国和巴西等主要出口国的农户。美国《华尔街日报》报道指出，欧洲是全球最大的猪肉出口地，对中国猪肉出口量的增加对欧洲国家来说无异于一场及时雨。"];
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
