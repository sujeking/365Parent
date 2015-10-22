//
//  NetManager.h
//  CloudinEnterprise
//
//  Created by Knight Lee on 13-3-22.
//  Copyright (c) 2013年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSNet.h"

@protocol NetManagerDelegate <NSObject>

@optional

-(void) requestStartforUrl:(NSString *) url;
-(void) requestCancelForUrl:(NSString *) url;

- (void) requestDidFinishWithData:(id) retData userInfo:(NSDictionary *) userInfo;
- (void) requestDidFinishWithData:(id) retData userInfo:(NSDictionary *) userInfo forUrl:(NSString *) url;

- (void) requestFailWithError:(NSError *) error userInfo:(NSDictionary *) userInfo;
- (void) requestFailWithError:(NSError *) error userInfo:(NSDictionary *) userInfo forUrl:(NSString *) url;

@end;

@interface NetManager : NSObject <WSNetDelegate>
{
    NSMutableArray *requestDelegates;
    NSMutableArray *requests;
    
    NSMutableArray *failedURLs;
    NSMutableArray *contexts;
    
    NSMutableDictionary *requstForURL;
}

+ (id)sharedManager;

- (void) requestWithURL:(NSString *) urlString delegate:(id<NetManagerDelegate>) delegate;
- (void) requestWithURL:(NSString *) urlString delegate:(id<NetManagerDelegate>) delegate withUserInfo:(NSDictionary *) userInfo;

#if NS_BLOCKS_AVAILABLE
- (void) requestWithURL:(NSString *) url delegate:(id)delegate success:(void (^)(id data)) success failure:(void (^)(NSError *error)) failure;
#endif

- (void)cancelForDelegate:(id<NetManagerDelegate>)delegate;

@end
