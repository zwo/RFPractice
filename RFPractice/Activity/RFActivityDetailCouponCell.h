//
//  RFActivityDetailCouponCell.h
//  RFPractice
//
//  Created by Zhou Weiou on 16-5-8.
//  Copyright (c) 2016年 Zhou Weiou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleActionBlock)(NSIndexPath *indexPath);

@interface RFActivityDetailCouponCell : UITableViewCell
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) HandleActionBlock handleActionBlock;
@end

@interface RFActivityDetailContactCell : UITableViewCell
@property (nonatomic,copy) HandleActionBlock handleActionBlock;
@end

@interface RFActivityDetailDescriptionCell : UITableViewCell
@property (nonatomic,copy) NSString *descriptionString;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *descritpionLabel;
- (CGFloat)cellHeight;
@end
