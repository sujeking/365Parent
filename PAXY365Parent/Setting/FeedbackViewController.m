//
//  FeedbackViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "FeedbackViewController.h"

#import "InternationalControl.h"
#import "Common.h"
#import "Config.h"
#import "DataSource.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize lblContent;
@synthesize lblInformation;
@synthesize txtEmail;
@synthesize scrollView;
@synthesize lblPlaceholder;

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
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 100);
    }

    
    
    //设备信息
    NSString *systemVersion=[[UIDevice currentDevice] systemVersion];
    NSString *device=[[UIDevice currentDevice] model];
    //NSString *version= [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    // app名称
    // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    getInformation = [NSString stringWithFormat:@"设备：%@ 系统：%@ 版本：%@.%@",device,systemVersion,app_Version,app_build];
    lblInformation.text = getInformation;
    
    lblContent.layer.borderColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:206/255.0 alpha:1.0].CGColor;
    lblContent.layer.borderWidth = 0.5;
    lblContent.layer.cornerRadius = 5.0;
    [lblContent becomeFirstResponder];
    
    lblContent.delegate = self;
    lblContent.returnKeyType = UIReturnKeyDone;
    
    
    NSString *getUserName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getUserName = [defaults objectForKey:@"cloudin_365paxy_nickname"];
        //txtEmail.text = getUserName;
    }
    
    scrollView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"意见反馈";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    //返回
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    //提交
    UIImage *saveImage = [UIImage imageNamed: @"btn_box_bg.png"];
    UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
    UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    [saveUIButton setTitle:@"提交" forState:UIControlStateNormal];
    [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveUIButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    saveUIButton.frame = CGRectMake(0, 0, saveImage.size.width, saveImage.size.height);
    [saveUIButton addTarget:self action:@selector(checkData) forControlEvents:UIControlEventTouchUpInside];
    [containingSaveView addSubview:saveUIButton];
    UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
    self.navigationItem.rightBarButtonItem = containingSaveButton;

    
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtEmail resignFirstResponder];
    [lblContent resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    if (![text isEqualToString:@""])
    {
        lblPlaceholder.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        lblPlaceholder.hidden = NO;
        
    }

    if ([text isEqualToString:@"\n"]) {
        [lblContent resignFirstResponder];
        return NO;
    }
    
    return YES;
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
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
        //
    //}];
}

-(void)checkData
{
    NSString *getContent = lblContent.text;

    if ([getContent isEqualToString:@""] || getContent == NULL) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请输入你的意见"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        [lblContent becomeFirstResponder];
    }
    else {
        
        loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
        [loadingView starRun];
        [self.scrollView addSubview:loadingView];
        
        [self performSelectorOnMainThread:@selector(postData) withObject:nil waitUntilDone:NO];//主线程
    }
    
}

- (void)postData
{
    @try {
        
        NSString *getContent = lblContent.text;
        NSString *getEmail = txtEmail.text;
        
        //设备信息
        NSString *systemVersion=[[UIDevice currentDevice] systemVersion];
        NSString *device=[[UIDevice currentDevice] model];
        //NSString *version= [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        getContent = [NSString stringWithFormat:@"%@",getContent];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow(infoDictionary);
        // app名称
        // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        // app build版本
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        
        //flag=0用户,=1后台内测,=2商户
        NSString *urlString = [[NSString alloc] initWithFormat:@"%@?content=%@&email=%@&device=%@&os=%@&app=%@.%@&flag=0",FeedbackUrl,getContent,getEmail,device,systemVersion,app_Version,app_build];
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
            
            if ([getStatus isEqualToString:@"1"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"恭喜你，提交成功！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                
                lblContent.text = @"";
                txtEmail.text = @"";
                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"提交失败"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }

    }
    @catch (NSException *exception) {
        //
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        //
    }
    
    [loadingView stopRun];
}

//按完Done键以后关闭键盘
- (IBAction) txtEmailDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
