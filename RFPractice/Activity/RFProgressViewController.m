//
//  RFProgressViewController.m
//  RFPractice
//
//  Created by zhouweiou on 16/9/5.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFProgressViewController.h"
#import "RFProgressBar.h"

@interface RFProgressViewController ()

@end

@implementation RFProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Color_White;
    RFProgressBar *bar = [RFProgressBar new];
    [self.view addSubview:bar];
    bar.percentage=0.5;
    bar.leftEndColor=RFRGBColor(248, 211, 74);
    bar.rightEndColor=RFRGBColor(231, 109, 102);
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 10));
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
