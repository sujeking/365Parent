//
//  AppDelegate.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "HXMainViewController.h"
#import "ApplyViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate,IChatManagerDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
    UITabBarController *tabBarViewController;
    
    int iFlagLogin;//标识是否显示关闭登陆页面返回按钮
    

    EMConnectionState _connectionState;
}

@property (nonatomic, retain) UITabBarController *tabBarViewController;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property int iFlagLogin;


@property (strong, nonatomic) HXMainViewController *mainController;


@end
