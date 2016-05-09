//
//  LayoutViewController.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-9.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "LayoutViewController.h"

@interface LayoutViewController ()

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Color_White;
    UIView *container=[UIView new];
    container.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    UIView *smallView=[UIView new];
    smallView.backgroundColor=[UIColor greenColor];
    [container addSubview:smallView];
    [smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(container.mas_bottom).offset(-20);
        make.centerX.equalTo(container.mas_right).multipliedBy(0.6);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
