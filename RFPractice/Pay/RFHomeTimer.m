//
//  RFHomeTimer.m
//  RFPractice
//
//  Created by zhouweiou on 16/5/18.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFHomeTimer.h"

@interface RFHomeTimer ()
@property (nonatomic,strong) GCDMulticastDelegate <RFHomeTimerDelegate> *multicastDelegate;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation RFHomeTimer

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    
    return sharedInstance;
}

- (instancetype)initPrivate
{
    self=[super init];
    if (self) {
        _multicastDelegate = (GCDMulticastDelegate <RFHomeTimerDelegate> *)[[GCDMulticastDelegate alloc] init];
    }
    return self;
}

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return self;
}

#pragma mark Configuration

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    if (delegateQueue == NULL) {
        delegateQueue=dispatch_get_main_queue();
    }
    [_multicastDelegate addDelegate:delegate delegateQueue:delegateQueue];
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    [_multicastDelegate removeDelegate:delegate delegateQueue:delegateQueue];
}

- (void)removeDelegate:(id)delegate
{
    [_multicastDelegate removeDelegate:delegate];
}

#pragma mark - Timer

- (void)resume
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)pause
{
    [_timer invalidate];
    _timer = nil;
    RFLog(@"pause");
}

- (void)onTimer:(NSTimer *)timer
{
    NSDate *now=[NSDate date];
    [_multicastDelegate timeToRefreshWithNowInterval:[now timeIntervalSince1970]];
}

@end
