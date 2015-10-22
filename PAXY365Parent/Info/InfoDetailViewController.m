//
//  InfoDetailViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/22.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "InfoDetailViewController.h"


#import "Common.h"
#import "CustomURLCache.h"
#import "MBProgressHUD.h"
#import "Config.h"
#import "ParseJson.h"
#import "DataSource.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "NJKWebViewProgressView.h"

@implementation InfoDetailViewController
{
    IBOutlet __weak UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@synthesize setTitle;
@synthesize setURL;
@synthesize webView = _webView;
@synthesize setNewsID;
@synthesize setNewsTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];
        [urlCache release];
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

//显示弹出消息
-(void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:nil forKey:@"cloudin_365paxy_message_warning"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 60, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = setTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    //关闭
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    
    [self loadFavorite:@"icon_favorite_off.png"];
    
    //检测收藏状态
    [NSThread detachNewThreadSelector:@selector(checkFavorite) toTarget:self withObject:nil];
    
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self loadWeb:setURL];
    [self addTapOnWebView];
}

//关闭页面
- (void)closeView
{
    
    NSString *getShowFlag = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        getShowFlag = [standardUserDefaults objectForKey:@"cloudin_365paxy_return_showback"];
    }
    
    if ([getShowFlag isEqualToString:@"YES"]) {
        self.navigationController.navigationBarHidden = YES;
    }
    else {
        self.navigationController.navigationBarHidden = FALSE;
    }
    
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

-(void)loadWeb:(NSString *)url
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:req];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

//检测是否已收藏
- (void)checkFavorite
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        if (getUserID==nil) {
            getUserID = @"0";
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&newsid=%@&uid=%@&flag=1",CheckFavoriteUrl,setNewsID,getUserID];
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            NSLog(@"Status=%@",getStatus);
            
            if ([getStatus isEqualToString:@"1"]) {
                
                flag = 1;
                //已收藏
                [self loadFavorite:@"icon_favorite_on.png"];
                //[btnFavorite setBackgroundImage:[UIImage imageNamed:@"icon_love_on.png"] forState:UIControlStateNormal];
            }
            if ([getStatus isEqualToString:@"2"]) {
                
                flag = 0;
                //未收藏
                [self loadFavorite:@"icon_favorite_off.png"];
                //[btnFavorite setBackgroundImage:[UIImage imageNamed:@"icon_love_off.png"] forState:UIControlStateNormal];
            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}

//收藏
- (void)gotoFavorite
{
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (flag==1) {
        //已收藏
        loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
        [loadingView starRun];
        [self.view addSubview:loadingView];
        
        [self performSelectorOnMainThread:@selector(cancelFavorite) withObject:nil waitUntilDone:NO];//主线程
        //[NSThread detachNewThreadSelector:@selector(cancelFavorite) toTarget:self withObject:nil];//子线程会与MBProgress冲突
        //[self cancelFavorite];
    }
    if (flag==0) {
        //未收藏
        loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
        [loadingView starRun];
        [self.view addSubview:loadingView];
        
        [self performSelectorOnMainThread:@selector(addFavorite) withObject:nil waitUntilDone:NO];//主线程
        //[NSThread detachNewThreadSelector:@selector(addFavorite) toTarget:self withObject:nil];
        //[self addFavorite];
    }
}


//添加收藏
- (void)addFavorite
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&flag=1&newsid=%@&uid=%@",AddFavoriteUrl,setNewsID,getUserID];
        
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            NSLog(@"Status=%@",getStatus);
            
            if ([getStatus isEqualToString:@"1"]) {
                
                flag = 1;
                //[btnFavorite setBackgroundImage:[UIImage imageNamed:@"icon_love_on.png"] forState:UIControlStateNormal];
                [self loadFavorite:@"icon_favorite_on.png"];
                [self showMessage:@"收藏成功"];
                
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"收藏失败"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
    [loadingView stopRun];
}

//取消收藏
- (void)cancelFavorite
{
    
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&newsid=%@&uid=%@&flag=1",CancelFavoriteUrl,setNewsID,getUserID];
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            NSLog(@"Status=%@",getStatus);
            
            if ([getStatus isEqualToString:@"1"]) {
                
                flag=0;
                
                //[btnFavorite setBackgroundImage:[UIImage imageNamed:@"icon_love_off.png"] forState:UIControlStateNormal];
                [self loadFavorite:@"icon_favorite_off.png"];
                [self showMessage:@"取消成功"];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"取消失败"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
    [loadingView stopRun];
}

-(void)loadFavorite:(NSString *)image
{
    UIView *rightButtonParentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    rightButtonParentView.backgroundColor = [UIColor clearColor];
    
    int buttonSize = 32;
    int rightOffset = 0;
    //收藏
    UIButton *btnFavorite = [[UIButton alloc] initWithFrame:CGRectMake(20, 6, buttonSize, buttonSize)];
    [btnFavorite setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btnFavorite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnFavorite.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btnFavorite addTarget:self action:@selector(gotoFavorite) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonParentView addSubview:btnFavorite];
    
    //分享
    UIButton *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(rightButtonParentView.frame.size.width - buttonSize - rightOffset, 6, buttonSize, buttonSize)];
    [btnShare setBackgroundImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
    [btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnShare.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btnShare addTarget:self action:@selector(addShare) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonParentView addSubview:btnShare];
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonParentView];
    [rightButtonParentView release];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

/* 图片点击放大显示 start */
-(void)addTapOnWebView
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.webView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
}

#pragma mark- TapGestureRecognizer
/**
 *  3.允许多个手势识别器共同识别
 
 默认情况下，两个gesture recognizers不会同时识别它们的手势,但是你可以实现UIGestureRecognizerDelegate协议中的
 gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:方法对其进行控制。这个方法一般在一个手势接收者要阻止另外一个手势接收自己的消息的时候调用，如果返回YES,则两个gesture recognizers可同时识别，如果返回NO，则并不保证两个gesture recognizers必不能同时识别，因为另外一个gesture recognizer的此方法可能返回YES。也就是说两个gesture recognizers的delegate方法只要任意一个返回YES，则这两个就可以同时识别；只有两个都返回NO的时候，才是互斥的。默认情况下是返回NO。
 *
 *  @param gestureRecognizer      手势
 *  @param otherGestureRecognizer 其他手势
 *
 *  @return YES代表可以多个手势同时识别，默认是NO，不可以多个手势同时识别
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    CGPoint pt = [sender locationInView:self.webView];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
    NSLog(@"image url=%@", urlToSave);
    if (urlToSave.length > 0) {
        [self showImageURL:urlToSave point:pt];
    }
}

//放大图片
-(void)showImageURL:(NSString *)url point:(CGPoint)point
{
    NSInteger count = 1;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //photo.srcImageView = self.scrollView.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
    
    /*
     UIImageView *showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
     showView.clipsToBounds = YES;
     showView.contentMode = UIViewContentModeScaleAspectFit;
     showView.center = point;
     [UIView animateWithDuration:0.5f animations:^{
     CGPoint newPoint = self.view.center;
     newPoint.y -= 32;
     showView.center = newPoint;
     }];
     
     showView.backgroundColor = [UIColor blackColor];
     //showView.alpha = 0.8;
     showView.userInteractionEnabled = YES;
     [self.view addSubview:showView];
     NSLog(@"URL:%@",url);
     [showView setImageWithURL:[NSURL URLWithString:url]];
     
     UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleViewTap:)];
     [showView addGestureRecognizer:singleTap];
     
     //添加捏合手势
     [showView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)]];
     
     [self.navigationController setNavigationBarHidden:YES animated:YES];*/
}

//缩放图片尺寸
- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    //缩放:设置缩放比例
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

//移除图片查看视图
-(void)handleSingleViewTap:(UITapGestureRecognizer *)sender
{
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/* 图片点击放大显示 end */



//添加分享到服务端
- (void)addShareData
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&flag=2&newsid=%@&uid=%@",AddFavoriteUrl,setNewsID,getUserID];
        
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            NSLog(@"Status=%@",getStatus);
            
            if ([getStatus isEqualToString:@"1"]) {
                
                flag = 1;
                //[btnFavorite setBackgroundImage:[UIImage imageNamed:@"icon_love_on.png"] forState:UIControlStateNormal];
                [self loadFavorite:@"icon_favorite_on.png"];
                [self showMessage:@"分享成功"];
                
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"分享失败"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
    [loadingView stopRun];
}


//分享给好友
- (void)addShare
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x"  ofType:@"png"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    // app名称
    // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSString *getTitle = [NSString stringWithFormat:@"%@,v%@.%@",AppName,app_Version,app_build];
    NSString *getContent = [NSString stringWithFormat:@"【365平安校园】%@,http://www.365paxy.org.cn",setNewsTitle];
    NSString *getURL = [NSString stringWithFormat:@"%@?id=%@",ViewNewsUrl,setNewsID];
    
    //自定义分享平台
    NSArray *shareList = [ShareSDK getShareListWithType:
                          
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,
                          ShareTypeWeixiFav,
                          ShareTypeSinaWeibo,
                          ShareTypeQQ,
                          ShareTypeFacebook,
                          ShareTypeTwitter,
                          ShareTypeWhatsApp,
                          ShareTypeCopy,
                          ShareTypeMail,
                          ShareTypeSMS,
                          
                          nil];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:getContent
                                       defaultContent:ShareAppContent
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:getTitle
                                                  url:getURL
                                          description:ShareAppName
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                    [self addShareData];
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }
                            }];
    
}

@end
