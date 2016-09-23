//
//  RFNetworkUtility.m
//  RFPractice
//
//  Created by zhouweiou on 16/9/18.
//  Copyright © 2016年 Zhou Weiou. All rights reserved.
//

#import "RFNetworkUtility.h"

static NSString * const kHost = @"http://smartoffice.rfchina.com";
static NSString * const kCookieStoreKey = @"RFCookieStoreKey";

@interface RFNetworkUtility ()
@property (nonatomic,strong) NSURLSession *session;
@end

@implementation RFNetworkUtility

@synthesize cookie=_cookie;

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return self;
}

- (instancetype)initPrivate
{
    self=[super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        sessionConfig.HTTPMaximumConnectionsPerHost = 5;
        sessionConfig.timeoutIntervalForResource = 120;
        sessionConfig.timeoutIntervalForRequest = 120;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

- (void)loginWithPhoneNum:(NSString *)phoneNum password:(NSString *)password completion:(void (^)(BOOL, NSString *))handler
{
    NSMutableURLRequest *request=[self postRequestWithParameters:@{@"phone":phoneNum,@"passwd":password} path:@"/api/user/login"];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            handler(NO,error.localizedDescription);
        }else{
            NSDictionary *responseDict=[self parseResponseFromData:data];
            if (!responseDict) {
                handler(NO,@"服务器返回异常");
            }else{
                
            }
        }
    }];
    [task resume];
}

- (NSMutableURLRequest *)getRequestWithParameters:(NSDictionary *)params path:(NSString *)path
{
    NSString *getURL=[NSString stringWithFormat:@"%@%@?data=%@",kHost,path,[self createBase64JSONFromDictionary:params]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:getURL]];
    request.allowsCellularAccess = YES;
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField: @"Accept"];
    return request;
}

- (NSMutableURLRequest *)postRequestWithParameters:(NSDictionary *)params path:(NSString *)path
{
    NSString *postURL=[kHost stringByAppendingString:path];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:postURL]];
    request.allowsCellularAccess = YES;
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField: @"Accept"];
    NSString *body=[@"data=" stringByAppendingString:[self createBase64JSONFromDictionary:params]];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

- (NSString *)createBase64JSONFromDictionary:(NSDictionary *)dict
{
    NSError *error;
    // option: Pass 0 if you don't care about the readability of the generated string or NSJSONWritingPrettyPrinted
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    if (!jsonData) {
        NSLog(@"json parser error");
        return nil;
    }
    return [jsonData base64EncodedStringWithOptions:0];
}

- (NSDictionary *)parseResponseFromData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    NSString *base64encodedString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:base64encodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:decodeData options:0 error:nil];
    return jsonDict;
}

#pragma mark - Cookie

- (NSString *)cookie
{
    if (_cookie) {
        return _cookie;
    } else {
        return [[NSUserDefaults standardUserDefaults] stringForKey:kCookieStoreKey];
    }
}

- (void)setCookie:(NSString *)cookie
{
    if ([cookie length]>0 && ![cookie isEqualToString:_cookie]) {
        _cookie=[cookie copy];
    }
}

@end
