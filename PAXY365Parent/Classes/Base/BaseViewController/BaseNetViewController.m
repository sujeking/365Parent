//
//  BaseNetViewController.m
//  FinalFantasy
//
//  Created by space bj on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseNetViewController.h"
#import "Utils.h"

#import "MBProgressHUD.h"
#import "JSONKit.h"


@implementation BaseNetViewController

@synthesize isShowLoading;

-(NSDictionary *) validationString:(id) data
{
    NSString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *dic = [jsonString objectFromJSONStringWithParseOptions:JKParseOptionUnicodeNewlines | JKParseOptionLooseUnicode];
    NSString *result = [dic objectForKey:@"result"];
    
    NSLog(@"result=%@",result);
   
    if ([result isEqualToString:@"1"]) 
    {
        NSString *number = [dic objectForKey:@"TotalNumber"];
        if (number) 
        {
            totalNumber = [number intValue];
        }
        
        return dic;
    }
    else if ([result isEqualToString:@"0"]) 
    {
        NSString *getFlag = nil;
        NSString *getSFlag = nil;
        NSString *getMessageWord = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            getFlag = [standardUserDefaults objectForKey:@"cloudin_365paxy_nodata_show_flag"];
            getSFlag = [standardUserDefaults objectForKey:@"cloudin_365paxy_nodata_show_sflag"];
            getMessageWord = [standardUserDefaults objectForKey:@"cloudin_365paxy_nodata_show_word"];
        }
        
        NSString *errorMsg = [dic objectForKey:@"msg"];
        //NSLog(@"服务器处理错误1，errorMsg:%@",errorMsg);
        
        if (errorMsg == nil)
        {
            errorMsg = getMessageWord;
            isHaveData = YES;
        }
        else{
            errorMsg = @"异常错误!";
        }
        
        if (![HUD isHidden])
        {
            [HUD hide:YES];
        }
        
        
        if ([getFlag isEqualToString:@"image"]) {
            if ([getSFlag isEqualToString:@"word"]) {
                //弹出文字提示
                [self showInfoViewWithMsg:errorMsg];
            }
            else{
                //默认出现图片
                [self showInfoViewWithNoDataMsg:errorMsg];
            }
        }
        else if ([getFlag isEqualToString:@"word"]) {
            //弹出文字提示
            [self showInfoViewWithMsg:errorMsg];
        }
        else{
            //弹出文字提示
            [self showInfoViewWithMsg:errorMsg];
        }
        
        return nil;
    }
    else
    {
        NSString *errorMsg = [dic objectForKey:@"msg"];
        NSLog(@"服务器处理错误，errorMsg:%@",errorMsg);

        if (errorMsg == nil) 
        {
            errorMsg = @"亲，没有啦!";
        }
        
        if (![HUD isHidden]) 
        {
            [HUD hide:YES];
        }
        [self showInfoViewWithMsg:errorMsg];
        
        
        return nil;
    }
}

#pragma -
#pragma 请求开始处理

-(void) requestStartforUrl:(NSString *) url
{
    if (isShowLoading) 
    {
        [self showLoadViewWithMsg:@"加载中..."];
    }
}

#pragma -
#pragma 请求结束

-(void) requestCancelForUrl:(NSString *) url
{
    [HUD hide:YES afterDelay:0.5f];    
}

- (void) requestDidFinishWithData:(id) retData userInfo:(NSDictionary *) userInfo
{
    NSDictionary *dic = [self validationString:retData];
    if (dic) 
    {
        if ([self respondsToSelector:@selector(netFinish:withUserInfo:)])
        {
            if (dic == nil)
            {
                [self netFinish:nil withUserInfo:userInfo];
            }
            
            else
            {
                [self netFinish:dic withUserInfo:userInfo];
            }
        }
        
        [HUD hide:YES afterDelay:0.5f];
    }
    else
    {
        if ([self respondsToSelector:@selector(netError:withUserInfo:)])
        {
            [self netError:nil withUserInfo:nil];
        }
    }
}

//- (void) requestDidFinishWithData:(id) retData userInfo:(NSDictionary *) userInfo forUrl:(NSString *) url
//{
//    NSDictionary *dic = [self validationString:retData];
//    
//    if ([self respondsToSelector:@selector(netFinish:withUserInfo:andURL:)]) 
//    {
//        [self netFinish:dic withUserInfo:userInfo andURL:url];
//    }
//    
//    [HUD hide:YES afterDelay:0.5f];
//}

-(void) requestFailWithError:(NSError *)error userInfo:(NSDictionary *)userInfo
{
    NSString *errorMsg = [NSString stringWithFormat:@"访问服务器出错,原因%@",error.localizedDescription];
    
    if (YES) 
    {
        if (HUD) 
        {
            [HUD hide:YES afterDelay:0.0f];
        }
        
        [self showInfoViewWithMsg:@"网络连接失败!"];
    }
    
    if ([self respondsToSelector:@selector(netError:withUserInfo:)])
    {
        [self netError:errorMsg withUserInfo:userInfo];
    }
}

-(void) requestFailWithError:(NSError *)error userInfo:(NSDictionary *)userInfo forUrl:(NSString *)url
{
    NSString *errorMsg = [NSString stringWithFormat:@"访问服务器出错,原因%@",error.localizedDescription];
    
    if (isShowLoading) 
    {
        if (HUD) 
        {
            [HUD hide:YES afterDelay:0.0f];
        }
        [self showInfoViewWithMsg:@"请求错误，请重试!"];
    }
    
    if ([self respondsToSelector:@selector(netError:withUserInfo:andURL:)]) 
    {
        [self netError:errorMsg withUserInfo:userInfo andURL:url];
    }
}



#pragma -
#pragma 重写以下方法

-(void) netFinish:(NSDictionary *) jsonString withUserInfo:(NSDictionary *) userInfo
{
    
}

-(void) netFinish:(NSDictionary *) jsonString withUserInfo:(NSDictionary *) userInfo andURL:(NSString *) url
{
    
}

-(void) netError:(NSString *) errorMsg withUserInfo:(NSDictionary *) userInfo
{
    
}

-(void) netError:(NSString *) errorMsg withUserInfo:(NSDictionary *) userInfo andURL:(NSString *) url
{
    
}


-(void) leftButtonItemClickBackCall
{
    [[NetManager sharedManager] cancelForDelegate:self];
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    currentPage = 1;
}

-(void) dealloc
{    
    [super dealloc];
}

@end
