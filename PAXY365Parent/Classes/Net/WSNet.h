//
//  WSNet.h
//  CloudinEnterprise
//
//  Created by Knight Lee on 13-3-22.
//  Copyright (c) 2013年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Utils.h"
#import "StringUtil.h"
#import "MBProgressHUD.h"


#define REQUET_PARAMS @"requestParams"
#define WSNET_CONTEXT @"WSNET_CONTEXT"


@class WSNet;

@protocol WSNetDelegate <NSObject>

@optional

//请求开始
-(void) wsNetRequestStart:(WSNet *) wsNetRequest;
//请求取消
-(void) wsNetRequestCancel:(WSNet *) wsNetRequest;


//请求完成
- (void) wsNetRequest:(WSNet *) wsRequest didFinishedWithData:(id) retData;

//请求失败
- (void) wsNetRequest:(WSNet *) wsRequest error:(NSError *) error;

@end


@interface WSNet : NSObject <ASIHTTPRequestDelegate> 
{
	id<WSNetDelegate> delegate;
	
    //请求URL
	NSString *requestURLString;
    //信息存储
    NSDictionary *userInfo;
    
    ASIHTTPRequest *request;
    int timout;
}

@property (nonatomic,assign) id<WSNetDelegate> delegate;

@property (nonatomic,retain) NSString *requestURLString;
@property (nonatomic,retain) NSDictionary *userInfo;

//发送异步步请求
-(NSString *) sendFormAsyRequst:(NSString *) urlString;

//初始化
-(id) initWithDelegate:(id<WSNetDelegate>) d;

//初始化
-(id) initWithDelegate:(id<WSNetDelegate>) d withUserInfo:(NSDictionary *) userInfo;

//取消请求
-(void) cancelRequest;

@end


