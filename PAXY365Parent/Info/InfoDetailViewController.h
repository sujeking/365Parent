//
//  InfoDetailViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/22.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface InfoDetailViewController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,UIGestureRecognizerDelegate>{
    
    NSString *setTitle;
    NSString *setURL;
    NSString *setNewsID;
    NSString *setNewsTitle;
    
    int flag;
    
    UIWebView *webView;
    
    //加载进度条
    GPRoundView *loadingView;
}

@property (nonatomic, retain) NSString *setTitle;
@property (nonatomic, retain) NSString *setURL;
@property (nonatomic, retain) NSString *setNewsID;
@property (nonatomic, retain) NSString *setNewsTitle;

@property(nonatomic, retain) UIWebView *webView;

@end