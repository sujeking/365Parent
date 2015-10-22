//
//  WebViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebViewController : UIViewController<UIWebViewDelegate, NJKWebViewProgressDelegate,UIGestureRecognizerDelegate>
{
    NSString *setTitle;
    NSString *setURL;
}

@property (nonatomic, retain) NSString *setTitle;
@property (nonatomic, retain) NSString *setURL;

@end