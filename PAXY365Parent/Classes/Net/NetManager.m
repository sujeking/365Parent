//
//  NetManager.m
//  CloudinEnterprise
//
//  Created by Knight Lee on 13-3-22.
//  Copyright (c) 2013年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "NetManager.h"

#if NS_BLOCKS_AVAILABLE

typedef void(^SuccessBlock)(id retData);
typedef void(^FailureBlock)(NSError *error);

@interface NetManager ()

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

@end
#endif

static NetManager *instance;

@implementation NetManager

#if NS_BLOCKS_AVAILABLE
@synthesize successBlock;
@synthesize failureBlock;
#endif

+ (id)sharedManager
{
    if (instance == nil)
    {
        instance = [[NetManager alloc] init];
    }
    
    return instance;
}

- (id)init
{
    if ((self = [super init]))
    {
        requestDelegates = [[NSMutableArray alloc] init];
        requests = [[NSMutableArray alloc] init];
        
        contexts = [[NSMutableArray alloc] init];
        
        requstForURL = [[NSMutableDictionary alloc] init];
        failedURLs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [requests release];
    [requestDelegates release];
    [contexts release];
    [requstForURL release];
    [failedURLs release];
    
    [super dealloc];
}


- (void) requestWithURL:(NSString *) url delegate:(id<NetManagerDelegate>) delegate withUserInfo:(NSDictionary *) userInfo
{
    WSNet *request = [[WSNet alloc] initWithDelegate:self];
    
    request.userInfo = userInfo;
    [request sendFormAsyRequst:url];
    
    [requestDelegates addObject:delegate];
    [requests addObject:request];
    
    [request release];
    
    //NSLog(@"userInfo=%@",url);
}

- (void) requestWithURL:(NSString *) url delegate:(id<NetManagerDelegate>) delegate
{
    [self requestWithURL:url delegate:delegate withUserInfo:nil];
}

#if NS_BLOCKS_AVAILABLE
- (void) requestWithURL:(NSString *) url delegate:(id)delegate success:(void (^)(id data)) success failure:(void (^)(NSError *error)) failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    [self requestWithURL:url delegate:delegate];
}
#endif

- (void)cancelForDelegate:(id<NetManagerDelegate>) delegate
{
    NSUInteger idx;
    
    while ((idx = [requestDelegates indexOfObjectIdenticalTo:delegate]) != NSNotFound)
    {
        WSNet *requestNet = [[requests objectAtIndex:idx] retain];
        
//        if (![requests containsObject:requestNet])
//        {
//            requestNet.delegate = nil;
//            [requestNet cancelRequest];
//        }
        [requestNet cancelRequest];
        requestNet.delegate = nil;
        
        [requestDelegates removeObjectAtIndex:idx];
        [requests removeObjectAtIndex:idx];
        
        [requestNet release];
    }
}


//请求开始
-(void) wsNetRequestStart:(WSNet *) wsRequest
{
    [wsRequest retain];
    
    for (NSInteger idx = (NSInteger)[requests count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        WSNet *wsRequest1 = (WSNet *)[requests objectAtIndex:uidx];
        
        if (wsRequest == wsRequest1)
        {
            id<NetManagerDelegate> delegate = [requestDelegates objectAtIndex:uidx];
            [[delegate retain] autorelease];
            
            if ([delegate respondsToSelector:@selector(requestStartforUrl:)]) 
            {
                [delegate requestStartforUrl:wsRequest.requestURLString];
            }
            
            break;
        }
    }
    
    [wsRequest release];
}



//请求取消
-(void) wsNetRequestCancel:(WSNet *) wsRequest
{
    [wsRequest retain];
    
    for (NSInteger idx = (NSInteger)[requests count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        WSNet *wsRequest1 = (WSNet *)[requests objectAtIndex:uidx];
        
        if (wsRequest == wsRequest1)
        {
            id<NetManagerDelegate> delegate = [requestDelegates objectAtIndex:uidx];
            [[delegate retain] autorelease];
            
            if ([delegate respondsToSelector:@selector(requestCancelForUrl:)]) 
            {
                [delegate requestCancelForUrl:wsRequest.requestURLString];
            }
            
            break;
        }
    }
    
    [wsRequest release];
}


//请求完成
- (void) wsNetRequest:(WSNet *) wsRequest didFinishedWithData:(id) retData
{
    [wsRequest retain];
    
    // Notify all the downloadDelegates with this downloader
    for (NSInteger idx = (NSInteger)[requests count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        WSNet *wsRequest1 = (WSNet *)[requests objectAtIndex:uidx];
        
        if (wsRequest == wsRequest1)
        {
            id<NetManagerDelegate> delegate = [requestDelegates objectAtIndex:uidx];
            [[delegate retain] autorelease];
            
            if (retData)
            {
                if ([delegate respondsToSelector:@selector(requestDidFinishWithData:userInfo:)])
                {
                    [delegate requestDidFinishWithData:retData userInfo:wsRequest.userInfo];
                }
                if ([delegate respondsToSelector:@selector(requestDidFinishWithData:userInfo:forUrl:)])
                {
                    [delegate requestDidFinishWithData:retData userInfo:wsRequest.userInfo forUrl:wsRequest.requestURLString];
                }
#if NS_BLOCKS_AVAILABLE
                if (self.successBlock)
                {
                    self.successBlock(retData);
                }
            }
#endif

            [requests removeObjectAtIndex:uidx];
            [requestDelegates removeObjectAtIndex:uidx];
            
            break;
        }
    }
    
    [wsRequest release];
}



//请求失败
- (void) wsNetRequest:(WSNet *) wsRequest error:(NSError *) error
{
    [wsRequest retain];
    
    // Notify all the downloadDelegates with this downloader
    for (NSInteger idx = (NSInteger)[requests count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        WSNet *wsRequest1 = (WSNet *)[requests objectAtIndex:uidx];
        
        if (wsRequest == wsRequest1)
        {
            id<NetManagerDelegate> delegate = [requestDelegates objectAtIndex:uidx];
            [[delegate retain] autorelease];
            
            if ([delegate respondsToSelector:@selector(requestFailWithError:userInfo:)])
            {
                [delegate requestFailWithError:error userInfo:wsRequest.userInfo];
            }
            if ([delegate respondsToSelector:@selector(webImageManager:didFailWithError:forURL:)])
            {
                [delegate requestFailWithError:error userInfo:wsRequest.userInfo forUrl:wsRequest.requestURLString];
            }
#if NS_BLOCKS_AVAILABLE
            if (self.failureBlock)
            {
                self.failureBlock(error);
            }
#endif
            
            break;
        }
    }
    
    [wsRequest release];
}


@end
