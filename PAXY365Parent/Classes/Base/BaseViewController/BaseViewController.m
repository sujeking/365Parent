//
//  BaseViewController.m
//  FinalFantasy
//
//  Created by space bj on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "Utils.h"
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "LeveyTabBarController.h"


#define Left_Button_Item_Normal_Image_Name @"anniu_zuo_zhenchang.png"
#define Left_Button_Item_HighLight_Image_Name @"anniu_zuo_xuanzhong.png"

#define Right_Button_Item_Normal_Image_Name @"anniu_you_zhenchang.png"
#define Right_Button_Item_HighLight_Image_Name @"anniu_you_xuanzhong.png"




#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_5_0

@implementation UINavigationBar(BgImage)

-(void) drawRect:(CGRect)rect
{
	UIImage *image = [UIImage imageNamed:@"nav_bg.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	
	//self.tintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1f];
}
@end

#endif

@implementation BaseViewController

@synthesize isLoadingData;
@synthesize titleText;
@synthesize HUD;
@synthesize infoHUD;
@synthesize isEnterBackground;
@synthesize imageViewNoData;

//不在前端显示 子类重写
-(void) enterBackgroundAction
{
    
}
//在前端显示 子类重写
-(void) enterForegroundAction
{
    
}

-(void) showLoadViewWithMsg:(NSString *) msg
{
    HUD.labelText = msg;
    HUD.margin = 20.0f;
	HUD.yOffset = -50.0f;
    [self.view bringSubviewToFront:HUD];
    [HUD show:YES];
}

-(void) showInfoViewWithMsg:(NSString *) msg
{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = msg;
	hud.margin = 20.0f;
	hud.yOffset = -50.0f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:1.5f];
}

//没有数据时显示
-(void) showInfoViewWithNoDataMsg:(NSString *) msg
{
    NSString *getFlag = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getFlag = [standardUserDefaults objectForKey:@"cloudin_365paxy_nodata_flag"];
    }
    
    int height = [getFlag intValue];
    
    imageViewNoData = [[UIImageView alloc] initWithFrame:CGRectMake(80, height, 150, 150)];
    imageViewNoData.image = [UIImage imageNamed:@"default_image_nodata.png"];
    [self.view addSubview:imageViewNoData];
}


#pragma -
#pragma 返回

-(void) leftButtonItemClick
{    
    if ([self respondsToSelector:@selector(leftButtonItemClickBackCall)]) 
    {
        [self leftButtonItemClickBackCall];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) leftButtonItemClickBackCall
{
    
}

-(void) initWithCustomView:(UIView *) customView type:(int) type
{
    UIBarButtonItem *buttonItem = [[[UIBarButtonItem alloc] initWithCustomView:customView] autorelease];
    
    if (type == 0) 
    {
        self.navigationItem.leftBarButtonItem = buttonItem;    
    }
    else
    {
        self.navigationItem.rightBarButtonItem = buttonItem;
    }
}

-(void) initButtonItemWithTitle:(NSString *) text atTarget:(id) target andSelector:(SEL) selctor type:(int) type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button setFrame:CGRectMake(0, 5, 48, 29)];

    [button setTitle:text forState:UIControlStateNormal];    
    
    if (type == 0) 
    {
        [button setBackgroundImage:[UIImage imageNamed:Left_Button_Item_Normal_Image_Name] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:Left_Button_Item_HighLight_Image_Name] forState:UIControlStateHighlighted];
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:Right_Button_Item_Normal_Image_Name] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:Right_Button_Item_HighLight_Image_Name] forState:UIControlStateHighlighted];
    }
    
    [button addTarget:target action:selctor forControlEvents:UIControlEventTouchUpInside];
    
    [self initWithCustomView:button type:type];
}

-(void) initLeftButtonItemWithTitle:(NSString *) text atTarget:(id) target andSelector:(SEL) selctor
{
    if (selctor == nil) 
    {
        [self initButtonItemWithTitle:text atTarget:target andSelector:@selector(leftButtonItemClick) type:0];
    }
    else
    {
        [self initButtonItemWithTitle:text atTarget:target andSelector:selctor type:0];
    }
}

-(void) initRightButtonItemWithTitle:(NSString *) text atTarget:(id) target andSelector:(SEL) selctor
{
    [self initButtonItemWithTitle:text atTarget:target andSelector:selctor type:1];    
}

#pragma -
#pragma 进入用户主页

-(void) goToUserProfile:(UIButton *) sender
{
    
}

#pragma -
#pragma 添加等待试图

-(void) addLoadingView:(UIView *) parentView
{
    isLoadingData = YES;
    
    UIView *tempView = [[UIView alloc] initWithFrame:parentView.bounds];
    
    tempView.backgroundColor = [UIColor whiteColor];
    tempView.tag = -100;
    [parentView addSubview:tempView];
    [tempView release];
    
    UIActivityIndicatorView *ac = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    ac.center = CGPointMake(parentView.bounds.size.width / 2 - ac.bounds.size.width / 2, 25);
    ac.tag = -101;
    [ac startAnimating];
    [parentView addSubview:ac];
    [ac release];
}

-(void) removeLoadingView:(UIView *) parentView
{
    isLoadingData = NO;
    for (UIView *temp in parentView.subviews) 
    {
        if (temp.tag == -100 || temp.tag == -101) 
        {
            [temp removeFromSuperview];
        }
    }
}


-(void) viewWillAppear:(BOOL)animated
{
    self.leveyTabBarController.tabBar.hidden = NO;
    [self.leveyTabBarController hidesTabBar:NO animated:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    
}


-(void) viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航条背景
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0)
    {
        if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
        }
    }    
//    self.navigationController.navigationBar.tintColor = [Utils colorWithHexString:@"#9b734a"];
//   
//    self.navigationController.navigationBar.layer.masksToBounds = NO;
//    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
//    self.navigationController.navigationBar.layer.shadowOpacity = 0.6;
//    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
   

    MBProgressHUD *temp = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD = temp;
    [temp release];
    [self.view addSubview:HUD];

    MBProgressHUD *temp1 = [[MBProgressHUD alloc] initWithView:self.view];
    self.infoHUD = temp1;
    [temp1 release];
    [self.view addSubview:infoHUD];
}

-(void) setTitleLabelText:(NSString *) text
{
    self.titleText = text;
    UILabel *label = (UILabel *)[self.navigationController.navigationBar viewWithTag:100];
    label.text = text;
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    //CLog(@"内存警告");
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    //CLog(@"内存释放 Class = %@",[[self class] description]);
    [titleText release];
    [HUD release];
    [infoHUD release];
    
    [super dealloc];
}

@end
