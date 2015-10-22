//
//  UpdateUserPasswordViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "UpdateUserPasswordViewController.h"

#import "AHReach.h"
#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "InternationalControl.h"
#import "Tool.h"

@interface UpdateUserPasswordViewController ()

@end

@implementation UpdateUserPasswordViewController
@synthesize txtPassword;
@synthesize txtRePassword;
@synthesize btnPost;
@synthesize scrollView;
@synthesize langLblRePassword;
@synthesize langLblNewPassword;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 100);
    }

    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;

    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"修改密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // back button
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    //默认弹出键盘获取焦点
    [txtPassword becomeFirstResponder];
    
}

//关闭、返回页面
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
    /*[self dismissViewControllerAnimated:YES
     completion:^{
     //TODO
     }];*/
    
}

- (IBAction) btnUpdatePressed: (id) sender
{
    btnPost.enabled = FALSE;
    [self updateData];
}

- (void)updateData
{
    AHReach *reach = [AHReach reachForDefaultHost];
	if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        NSString *getPassword = txtPassword.text;
        NSString *getRePassword = txtRePassword.text;
        if (getPassword.length==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入密码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtPassword becomeFirstResponder];
             btnPost.enabled = TRUE;
        }
        else if(![Tool isPassword:getPassword]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入正确的密码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtPassword becomeFirstResponder];
            btnPost.enabled = TRUE;
            
        }
        else if(getRePassword.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入确认密码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtRePassword becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else if(![Tool isPassword:getRePassword]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入正确的确认密码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtRePassword becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else if(![getPassword isEqualToString:getRePassword]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"两次输入的密码不一致"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtRePassword becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else if([getPassword isEqualToString:getRePassword]){
            
            loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
            [loadingView starRun];
            [self.view addSubview:loadingView];

            [NSThread detachNewThreadSelector:@selector(postUpdateData) toTarget:self withObject:nil];
            //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(postUpdateData) userInfo:nil repeats:NO];
            
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"网络连接失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        btnPost.enabled = TRUE;
    }
}


- (void)postUpdateData
{
    //读取数据
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    NSString *getPassword = txtPassword.text;
    
    @try {
        
        NSString *getUID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            
            getUID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&password=%@",UpdateUserPasswordUrl,getUID,getPassword];
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

                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_me"];
                
                [self closeView];
                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"修改失败"
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
    
    btnPost.enabled = TRUE;
    [loadingView stopRun];//停止加载动画
}

//按完Done键以后关闭键盘
- (IBAction) txtPasswordNextEditing:(id)sender
{
    [txtRePassword becomeFirstResponder];
}

- (IBAction) txtRePasswordNextEditing:(id)sender
{
    [txtRePassword resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
