//
//  UserRegisterViewController.m
//  WeCicerone
//
//  Created by Cloudin's Adin on 14-9-15.
//  Copyright (c) 2014年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "UserRegisterViewController.h"

#import "UserCheckMobileViewController.h"

#import "DataSource.h"
#import "Config.h"
#import "Common.h"
#import "AHReach.h"
#import "Tool.h"

@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController
@synthesize txtMobile;
@synthesize scrollView;

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
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 50);
    }
    
    [txtMobile becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
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
    
    //下一步
    UIImage *backButtonImage = [UIImage imageNamed: @"btn_box_bg.png"];
    UIView *containingBackView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)] autorelease];
    UIButton *backUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backUIButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backUIButton setTitle:@"下一步" forState:UIControlStateNormal];
    [backUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backUIButton.titleLabel.font = [UIFont systemFontOfSize:12];
    backUIButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    [backUIButton addTarget:self action:@selector(checkData) forControlEvents:UIControlEventTouchUpInside];
    [containingBackView addSubview:backUIButton];
    UIBarButtonItem *containingBackButton = [[[UIBarButtonItem alloc] initWithCustomView:containingBackView] autorelease];
    self.navigationItem.rightBarButtonItem = containingBackButton;
    
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = TxtTitle;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"验证手机号码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    

    [txtMobile becomeFirstResponder];
    
    
    //验证输入数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtMobile];
}

//关闭页面
- (void)closeView
{
    //[self.navigationController popViewControllerAnimated:YES]; //back
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//检测数据
- (void)checkData
{
    AHReach *reach = [AHReach reachForDefaultHost];
	if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getUserName = txtMobile.text;

        if (getUserName.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入手机号码！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(getUserName.length!=11){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"输入的手机号码不正确！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
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
    }
}

//提交数据
- (void)postData
{
    NSString *getMobile = txtMobile.text;
    int random = (arc4random() % 10000) + 99999;
    NSString *randomNUm = [NSString stringWithFormat:@"%d",random];
    
    @try {
        
        //提交
        NSString *urlString = [NSString stringWithFormat:@"%@?mobile=%@&code=%@",ValidateVode,getMobile,randomNUm];
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
            
            //1=成功，2=密码错误，3=帐户不存在，4=异常错误
            if ([getStatus isEqualToString:@"1"]) {
                //发送验证码成功
                NSLog(@"Status=%@",@"发送验证码成功");
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:getMobile forKey:@"cloudin_365paxy_verify_mobile"];
                [defaults setObject:randomNUm forKey:@"cloudin_365paxy_verify_code"];
                
                UserCheckMobileViewController *nextController = [UserCheckMobileViewController alloc];
                nextController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextController animated:YES];
            }
            else if ([getStatus isEqualToString:@"2"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"对不起，手机号码已被注册！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else {
                //发送验证码失败
                NSLog(@"Status=%@",@"发送验证码失败");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"验证码发送失败，请重试！"
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
    
}



//格式化显示输入
-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    //1000000
    if (self.txtMobile == textField)  //判断是否时我们想要限定的那个输入框
    {
        if(toBeString.length>10){
            txtMobile.text = [toBeString substringWithRange:NSMakeRange(0, 11)];
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
