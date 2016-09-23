//
//  RFNetworkUtility.h
//  RFPractice
//
//  Created by zhouweiou on 16/9/18.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFNetworkUtility : NSObject

+ (instancetype)sharedInstance;
- (void)loginWithPhoneNum:(NSString *)phoneNum password:(NSString *)password completion:(void(^)(BOOL success,NSString *message))handler;
@property (strong, nonatomic) NSString *cookie;

@end
