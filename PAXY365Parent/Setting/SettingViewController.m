//
//  SettingViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SettingViewController.h"

#import "FeedbackViewController.h"
#import "WebViewController.h"
#import "SettingsViewController.h"

#import "Common.h"
#import "Config.h"
#import "GRAlertView.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>


/* web start */
#import "TOWebViewController.h"

#ifndef NSFoundationVersionNumber_iOS_6_1
#define NSFoundationVersionNumber_iOS_6_1  993.00
#endif

/* Detect if we're running iOS 7.0 or higher */
#define MINIMAL_UI (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
/* web end */

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize scrollView;
@synthesize lblCache;
@synthesize switchMessage;
@synthesize lblVersion;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,700);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,700 + 100);
    }

    double dVersion = [[[UIDevice currentDevice] systemVersion] doubleValue];
    if (dVersion<7.0) {
        [switchMessage setFrame:CGRectMake(200, 140, 30, 31)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;
    
    //显示菜单文字
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //返回
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    
    //获取版本号
    //NSString *getVersion= [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    // app名称
    // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    lblVersion.text = [NSString stringWithFormat:@"v%@.%@",app_Version,app_build];

    lblCache.hidden = TRUE;
    [self checkTmpSize];
}

- (void)checkTmpSize {
    
    NSString *diskCachePath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"CloudinPAXY"];
    float totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:diskCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
        totalSize += length / 1024.0 / 1024.0;
    }
    NSLog(@"tmp size is %.2f",totalSize);
    
    //lblCache.text  = [NSString stringWithFormat:@"%.2f",totalSize];
}


//返回页面
- (void)backView
{
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

- (void)doLocalNotifictionListOrMap
{
    if (switchMessage.isOn==YES) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"ON" forKey:@"cloudin_365paxy_message_status"];
        
    }else if(switchMessage.isOn==NO){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"OFF" forKey:@"cloudin_365paxy_message_status"];
    }
}


- (IBAction) btnClearCachePressed: (id) sender
{
    [self showDialogMessage:@"你确定要清除缓存吗？"];
}


//客户服务
- (IBAction) btnServicePressed: (id) sender
{
    //NSURL *url = [NSURL URLWithString:ServiceUrl];
    //TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //[self.navigationController pushViewController:webViewController animated:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
    
    WebViewController *vc = [WebViewController alloc];
    vc.setTitle = @"客户服务";
    vc.setURL = ServiceUrl;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];

}

//在线问答
- (IBAction) btnFAQPressed: (id) sender
{
    //NSURL *url = [NSURL URLWithString:FAQUrl];
    //TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //[self.navigationController pushViewController:webViewController animated:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
    
    WebViewController *vc = [WebViewController alloc];
    vc.setTitle = @"在线问答";
    vc.setURL = FAQUrl;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];
}

//关于我们
- (IBAction) btnAboutPressed: (id) sender
{
    //NSURL *url = [NSURL URLWithString:APPUrl];
    //TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //[self.navigationController pushViewController:webViewController animated:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
    
    WebViewController *vc = [WebViewController alloc];
    vc.setTitle = @"关于我们";
    vc.setURL = APPUrl;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];
}

//意见反馈
- (IBAction) btnFeedbackPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
    
    FeedbackViewController *nextController = [[FeedbackViewController alloc] init];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//聊天设置
- (IBAction) btnChatSettingPressed: (id) sender
{
    SettingsViewController *nextController = [[SettingsViewController alloc] init];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//弹出消息对话框
- (void)showDialogMessage:(NSString *)message
{
    GRAlertView *alert;
    alert = [[GRAlertView alloc] initWithTitle:@"提醒"
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"确定", nil];
    
    [alert setTopColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           middleColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           bottomColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
             lineColor:[UIColor colorWithRed:153/255.0 green:206/255.0 blue:0/255.0 alpha:1.0]];
    
    
    [alert setFontName:@"Cochin-Bold"
             fontColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:226/255.0 alpha:1.0]
       fontShadowColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]];
    
    //[alert setImage:@"login_icon.png"];
    alert.animation = GRAlertAnimationNone;
    [alert show];
}

//处理弹出框动作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"Button pushed: %@, index %i", alertView.title, buttonIndex);
    if (buttonIndex == 1) {
        //确定
        [self clearCache];
    }
    else{
        //取消
        
    }
}

#pragma 清理缓存图片
- (void)clearCache
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                    message:@"清除成功"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
