//
//  LayoutViewController.m
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-9.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import "LayoutViewController.h"
#import "RFHomeSegmentedControl.h"

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
    
    RFHomeSegmentedControl *segment=[[RFHomeSegmentedControl alloc] initWithFrame:CGRectMake(0, 300, 300, 40) leftTitle:@"10:00 即将开抢" rightTitle:@"全部房源"];
    [self.view addSubview:segment];
    
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[self badgeWithNumber:@"33"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(27, 17));
        make.top.equalTo(self.view).offset(90);
    }];
}

- (UIImage*)badgeWithNumber:(NSString *)numberString
{
    CGSize badgeSize=CGSizeMake(27, 17);
    UIGraphicsBeginImageContextWithOptions(badgeSize, NO, 1);
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 27, 17) cornerRadius: 8.5];
    [Color_White setFill];
    [rectanglePath fill];
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 11], NSForegroundColorAttributeName: Color_Main, NSParagraphStyleAttributeName: textStyle};
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGSize textSize = [numberString boundingRectWithSize:CGSizeMake(INFINITY, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:textFontAttributes context:nil].size;
    CGContextSaveGState(context);
    CGRect textRect = CGRectMake((badgeSize.width-textSize.width)/2, (badgeSize.height-badgeSize.height)/2, textSize.width, textSize.height);
    CGContextClipToRect(context, textRect);
    [numberString drawInRect: textRect withAttributes: textFontAttributes];
    CGContextRestoreGState(context);
    
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
}

@end
