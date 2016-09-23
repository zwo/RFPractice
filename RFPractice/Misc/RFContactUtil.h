//
//  RFContactUtil.h
//  SuperCommunity
//
//  Created by zhouweiou on 16/9/14.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFContactUtil : NSObject
@property (nonatomic,strong) NSMutableArray *pureContactArray;
+ (instancetype)sharedInstance;
- (BOOL)canAccessToNativeAddressBook;
@end
