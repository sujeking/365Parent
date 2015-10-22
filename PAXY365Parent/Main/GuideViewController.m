//
//  GuideViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "GuideViewController.h"

#import "MainViewController.h"

#import "HMGLTransitionManager.h"
#import "DoorsTransition.h"
#import "UIImage+Extras.h"

#import "Common.h"
#import "Config.h"
#import "ParseJson.h"
#import "DataSource.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface GuideViewController ()

@end

@implementation GuideViewController
@synthesize btnEnter;
@synthesize pageControl;
//@synthesize guideImage;
@synthesize activityIndicator;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"000000");
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        NSLog(@"111111");
        //根据不同屏幕尺寸，显示位置
        //[self.btnEnter setFrame:CGRectMake(100, 450, 120, 41)];
        [self.pageControl setFrame:CGRectMake(141, 450 + 50, 39, 37)];
        
        btnEnter = [[UIButton alloc] initWithFrame: CGRectMake(130, 460, 50, 44)];
        [btnEnter setBackgroundImage:[UIImage imageNamed:@"btn_enter.png"] forState:UIControlStateNormal];
        [btnEnter addTarget:self action:@selector(gotoEnter) forControlEvents:UIControlEventTouchUpInside];
        [btnEnter setHidden:TRUE];
        [self.view addSubview:btnEnter];
        
    }
    else{
        NSLog(@"222222");
        //根据不同屏幕尺寸，显示位置
        //[self.btnEnter setFrame:CGRectMake(100, 450 - 250, 120, 41)];
        [self.pageControl setFrame:CGRectMake(141, 450 + 50 - 150, 39, 37)];
        
        btnEnter = [[UIButton alloc] initWithFrame: CGRectMake(130, 460 - 80, 50, 44)];
        [btnEnter setBackgroundImage:[UIImage imageNamed:@"btn_enter.png"] forState:UIControlStateNormal];
        [btnEnter addTarget:self action:@selector(gotoEnter) forControlEvents:UIControlEventTouchUpInside];
        [btnEnter setHidden:TRUE];
        [self.view addSubview:btnEnter];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    int h = [UIScreen mainScreen].bounds.size.height;
    bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, h)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    bigScrollView.backgroundColor = [UIColor whiteColor];
    bigScrollView.tag = 10;
    bigScrollView.showsHorizontalScrollIndicator = NO;
    bigScrollView.showsVerticalScrollIndicator = NO;
    bigScrollView.userInteractionEnabled = YES;
    bigScrollView.pagingEnabled = YES;
    bigScrollView.bounces = NO;
    // * 3标示显示3个
    bigScrollView.contentSize = CGSizeMake(320 * 5, h);
    bigScrollView.delegate = self;
    

    //加载服务的引导画面图片
    //[self loadGuideImages];
    
    
    for (int i = 0 ; i < 5; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, h)];
        imageView.userInteractionEnabled = NO;
        [bigScrollView addSubview:imageView];
        [imageView release];
        
        NSString *imageName = [NSString stringWithFormat:@"guide%d",i];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        imageView.image = image;
    }
    
    [self.view addSubview:bigScrollView];
    [bigScrollView release];
    
    //设置滑动页码数量
    [self.pageControl setNumberOfPages:3];
    
    [self.view bringSubviewToFront:self.btnEnter];
    [self.view bringSubviewToFront:self.pageControl];
    self.btnEnter.hidden = YES;
}


#pragma mark -
#pragma mark Scroll View Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self calculatePageFor:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self calculatePageFor:scrollView];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.btnEnter.hidden = YES;
    
}

- (void)calculatePageFor:(UIScrollView *)scrollView
{
    NSInteger nowPage = (int)scrollView.contentOffset.x / (int)scrollView.bounds.size.width;
    if(nowPage == 4){
        self.btnEnter.hidden = NO;
        //滑动最后一页进入
        //[self gotoEnter];
    }
    else
    {
        self.btnEnter.hidden = YES;
    }
    self.pageControl.currentPage = nowPage;
}

//立即体验按钮
-(void)gotoEnter
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_flag_showback"];
    
    MainViewController *nextController = [MainViewController alloc];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

-(void) dealloc
{
    self.btnEnter = nil;
    self.pageControl = nil;
    [super dealloc];
}

@end
