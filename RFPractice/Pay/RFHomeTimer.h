//
//  RFHomeTimer.h
//  RFPractice
//
//  Created by zhouweiou on 16/5/18.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDMulticastDelegate.h"

@interface RFHomeTimer : NSObject
+ (instancetype)sharedInstance;
- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate;
- (void)pause;
- (void)resume;
@end

@protocol RFHomeTimerDelegate <NSObject>

- (void)timeToRefreshWithNowInterval:(NSTimeInterval)interval;

@end
