//
//  UserCheckMobileViewController.m
//  WeCicerone
//
//  Created by Cloudin's Adin on 14-9-15.
//  Copyright (c) 2014年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "UserCheckMobileViewController.h"

#import "WebViewController.h"

#import "DataSource.h"
#import "Config.h"
#import "Common.h"
#import "AHReach.h"

@interface UserCheckMobileViewController ()

@end

@implementation UserCheckMobileViewController
@synthesize txtSMSCode;
@synthesize lblShowMessage;
@synthesize scrollView;
@synthesize txtPassword;
@synthesize txtRePassword;
@synthesize txtNiceName;
@synthesize btnPost;
@synthesize btnCheck;
@synthesize btnPrivacy;

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
        scrollView.contentSize = CGSizeMake(320,700 + 50);
    }
    
    [txtSMSCode becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = MainBgColor;

    
    //Close
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    

    
    NSString *getMobile = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getMobile = [standardUserDefaults objectForKey:@"cloudin_365paxy_verify_mobile"];
    }
    
    lblShowMessage.text = [NSString stringWithFormat:@"包含验证码的短信已发送至%@",getMobile];
    
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = TxtTitle;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"免费注册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
  
    //验证输入数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtSMSCode];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtNiceName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtPassword];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtRePassword];
    
    num = 1;
    ok = 0;
    
}

//关闭页面
- (void)closeView
{
    //[self.navigationController popViewControllerAnimated:YES]; //back
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//按完Done键以后关闭键盘
- (IBAction) txtSMSCodeEditing:(id)sender
{
    [txtNiceName becomeFirstResponder];
}

- (IBAction) txtNickNameEditing:(id)sender
{
    [txtPassword becomeFirstResponder];
}

- (IBAction) txtPasswordEditing:(id)sender
{
    [txtRePassword becomeFirstResponder];
}

- (IBAction) txtRePasswordEditing:(id)sender
{
    [txtRePassword resignFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtSMSCode resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtRePassword resignFirstResponder];
}

- (IBAction) btnPostPressed: (id) sender
{
    btnPost.enabled = FALSE;
    [self checkData];
}

//检测数据
- (void)checkData
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getOldCode = nil;
        NSString *getMobilePhone = nil;
        NSString *getVerifyFlag = nil;
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            getOldCode = [standardUserDefaults objectForKey:@"cloudin_365paxy_verify_code"];
            getMobilePhone = [standardUserDefaults objectForKey:@"cloudin_365paxy_verify_mobile"];
            getVerifyFlag = [standardUserDefaults objectForKey:@"cloudin_365paxy_verify_mobile_flag"];
            
        }
        
        NSString *getNickName = txtNiceName.text;
        NSString *getCode = txtSMSCode.text;
        NSString *getPassword = txtPassword.text;
        NSString *getRePassword = txtRePassword.text;
        
        if (![getCode isEqualToString:getOldCode]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"验证码不正确，请重试！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getNickName.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"昵称不能为空！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getPassword.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"密码不能为空！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getRePassword == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"确认密码不能为空！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if(![getPassword isEqualToString:getRePassword]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"两次输入的密码不一致！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (ok == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"必须勾选隐私条款！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else {
            
            [self postData];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"网络连接失败！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        btnPost.enabled = TRUE;
    }
}


- (IBAction) btnCheckPressed: (id) sender
{
    if (num%2) {
        ok = 1;
         [btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_checked.png"] forState:UIControlStateNormal];
    }
    else{
        ok = 0;
        [btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_unchecked.png"] forState:UIControlStateNormal];
    }
    
    num++;
}

- (IBAction) btnPrivacyPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];

    WebViewController *vc = [WebViewController alloc];
    vc.setTitle = @"隐私条款";
    vc.setURL = PrivacyUrl;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)postData
{

    NSString *getNickName = txtNiceName.text;
    NSString *getPassword = txtPassword.text;

    @try {
        
        NSString *getLat = nil;
        NSString *getLng = nil;
        NSString *getMobile = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            getLat = [standardUserDefaults objectForKey:@"cloudin_365paxy_lat"];
            getLng = [standardUserDefaults objectForKey:@"cloudin_365paxy_lng"];
            getMobile = [standardUserDefaults objectForKey:@"cloudin_365paxy_verify_mobile"];
        }
        
        if (getLat==nil) {
            getLat = DefaultLat;
        }
        if (getLng==nil) {
            getLng = DefaultLng;
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&mobile=%@&nickname=%@&password=%@&gender=保密&lat=%@&lng=%@&paid=0&puid=0&pcid=0&flag=1",RegisterUrl,getMobile,getNickName,getPassword,getLat,getLng];
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
            
            if ([getStatus isEqualToString:@"1"]) { //注册成功
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"2" forKey:@"cloudin_365paxy_message_login"];
                [defaults setObject:getMobile forKey:@"cloudin_365paxy_temp_mobilephone"];
                
                
                btnPost.enabled = TRUE;
                [self closeView];
            }
            else if ([getStatus isEqualToString:@"2"]) { //用户已存在

                btnPost.enabled = TRUE;
            }
            else {
                NSLog(@"Exception=未知错误");
            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception=%@", e);
        btnPost.enabled = TRUE;
    }
    
}

//格式化显示输入
-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    //1000000
    if (self.txtSMSCode == textField)  //判断是否时我们想要限定的那个输入框
    {
        if(toBeString.length>6){
            txtSMSCode.text = [toBeString substringWithRange:NSMakeRange(0, 7)];
        }
        
    }
    
    //超过10个汉字自动截取
    if (self.txtNiceName == textField)
    {
        if(toBeString.length>10){
            txtNiceName.text = [toBeString substringWithRange:NSMakeRange(0, 10)];
        }
        
    }
    
    if (self.txtPassword == textField)
    {
        if(toBeString.length>20){
            txtPassword.text = [toBeString substringWithRange:NSMakeRange(0, 20)];
        }
        
    }
    
    if (self.txtRePassword == textField)
    {
        if(toBeString.length>20){
            txtRePassword.text = [toBeString substringWithRange:NSMakeRange(0, 20)];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
