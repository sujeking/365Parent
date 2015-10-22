//
//  WebViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "WebViewController.h"

#import "Common.h"
#import "CustomURLCache.h"
#import "MBProgressHUD.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "NJKWebViewProgressView.h"

@implementation WebViewController
{
    IBOutlet __weak UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@synthesize setURL;
@synthesize setTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = setTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    //关闭
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[UIBarButtonItem alloc] initWithCustomView:containingLogoView];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getShowFlag = [defaults objectForKey:@"cloudin_365paxy_return_showback"];
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



/* 图片点击放大显示 start */
-(void)addTapOnWebView
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_webView addGestureRecognizer:singleTap];
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
    CGPoint pt = [sender locationInView:_webView];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    NSString *urlToSave = [_webView stringByEvaluatingJavaScriptFromString:imgURL];
    NSLog(@"image url=%@", urlToSave);
    if (urlToSave.length > 0) {
        [self showImageURL:urlToSave point:pt];
    }
}

//放大图片
-(void)showImageURL:(NSString *)url point:(CGPoint)point
{
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
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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

@end
