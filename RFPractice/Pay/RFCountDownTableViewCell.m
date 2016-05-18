//
//  RFCountDownTableViewCell.m
//  RFPractice
//
//  Created by zhouweiou on 16/5/18.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFCountDownTableViewCell.h"
#import "RFHomeTimer.h"

@interface RFCountDownTableViewCell ()
@property (nonatomic,strong) UILabel *countdownLabel;
@property (nonatomic) NSTimeInterval endTimeInterval;
@end

@implementation RFCountDownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.countdownLabel=[UILabel new];
        self.countdownLabel.font=Font_Big;
        self.countdownLabel.textColor=Color_Main;
        [self.contentView addSubview:self.countdownLabel];
        [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        self.endTimeInterval=1463559080;
    }
    return self;
}

- (void)dealloc
{
    RFLog(@"dealloc");
    [[RFHomeTimer sharedInstance] removeDelegate:self];
}

- (void)timeToRefreshWithNowInterval:(NSTimeInterval)interval
{
    NSTimeInterval diff=self.endTimeInterval - interval;
    if (diff>0) {
        int second = (int)diff  % 60;
        int minute = ((int)diff / 60) % 60;
        int hours = diff / 3600;
        self.countdownLabel.text=[NSString stringWithFormat:@"%02d:%02d:%02d",hours,minute,second];
    }
}

@end
