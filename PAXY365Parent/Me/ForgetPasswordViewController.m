//
//  ForgetPasswordViewController.m
//  JiaQiQu
//
//  Created by Cloudin's Adin on 14-2-14.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "ForgetPasswordViewController.h"

#import "InternationalControl.h"
#import "Common.h"
#import "DataSource.h"
#import "Config.h"
#import "Tool.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController
@synthesize txtMobilePhone;
@synthesize btnPost;
@synthesize langLblMoiblePhone;
@synthesize langLblTips;
@synthesize btnMobileCode;
@synthesize txtCode;
@synthesize langLblCode;
@synthesize txtPassword;
@synthesize txtRePassword;
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
    [super viewDidAppear:animated];

    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        
        scrollView.contentSize = CGSizeMake(320,600 + 50);
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtMobilePhone];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtCode];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtPassword];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtRePassword];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;
    
    secondsNum = 60;//60秒倒计时
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = TxtTitle;
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"忘记密码";
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

    
    //一定要记得声明代理协议，否则不起作用
    scrollView.delegate = self;
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtMobilePhone];
}

//关闭或返回
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    //[self.navigationController popViewControllerAnimated:YES]; //back
    
    [self dismissViewControllerAnimated:YES completion:^{
        //TODO
    }];
}

//按完Done键以后关闭键盘
- (IBAction) txtMobileEditing:(id)sender
{
    //获得焦点
    [txtCode becomeFirstResponder];
}
- (IBAction) txtCodeEditing:(id)sender
{
    //获得焦点
    [txtPassword becomeFirstResponder];
}
- (IBAction) txtPasswordEditing:(id)sender
{
    //获得焦点
    [txtRePassword becomeFirstResponder];
}
- (IBAction) txtRepasswordEditing:(id)sender
{
    //获得焦点
    [txtRePassword resignFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtMobilePhone resignFirstResponder];
    [txtCode resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtRePassword resignFirstResponder];
}

//发送新密码
- (IBAction) btnPostPressed: (id) sender
{
    btnPost.enabled = FALSE;
    [self checkData];
}

- (void)checkData
{
    //检测手机号码是否正确
    @try {
        
        NSString *getMobilePhone = txtMobilePhone.text;

        if (getMobilePhone.length==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入手机号码"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtMobilePhone becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else if(getMobilePhone.length!=11){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"手机号码不正确"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtMobilePhone becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else{
            
            loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
            [loadingView starRun];
            [self.view addSubview:loadingView];
            
            [NSThread detachNewThreadSelector:@selector(postData) toTarget:self withObject:nil];
            
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        btnPost.enabled = TRUE;
        return;
    }

}

//提交数据
-(void)postData
{
    @try {
        
        NSString *getMobilePhone = txtMobilePhone.text;
        NSString *getPassword = txtPassword.text;
        
        getMobilePhone = [getMobilePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&mobile=%@&password=%@",ForgetPasswordUrl,getMobilePhone,getPassword];
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
                [defaults setObject:@"3" forKey:@"cloudin_cheese_show_flag"];
                
                [self closeView];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:langTxtAlertFail
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
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
    [loadingView stopRun];

}


//格式化显示输入手机号码：12345678 -》1234 5678
-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    //15000772515
    if (self.txtMobilePhone == textField)  //判断是否时我们想要限定的那个输入框
    {
        if(toBeString.length>11){
            txtMobilePhone.text = [toBeString substringWithRange:NSMakeRange(0, 12)];
        }
        
    }
    
    if (self.txtCode == textField)  //判断是否时我们想要限定的那个输入框
    {
        if(toBeString.length>6){
            txtCode.text = [toBeString substringWithRange:NSMakeRange(0, 7)];
        }
        
    }
    
    if (self.txtPassword == textField)  //判断是否时我们想要限定的那个输入框
    {
        if(toBeString.length>20){
            txtPassword.text = [toBeString substringWithRange:NSMakeRange(0, 21)];
        }
        
    }
    
    if (self.txtRePassword == textField)  //判断是否时我们想要限定的那个输入框
    {
        if(toBeString.length>20){
            txtRePassword.text = [toBeString substringWithRange:NSMakeRange(0, 21)];
        }
        
    }
    
    
}



//获取验证码
- (IBAction) btnGetMobileValidateCodePressed: (id) sender
{
   
    NSString *getMobilePhone = txtMobilePhone.text;
    getMobilePhone = [getMobilePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *getFirstWord = nil;
    if (getMobilePhone.length>1) {
        getFirstWord = [getMobilePhone substringToIndex:1];
    }
    
    if (getMobilePhone.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请输入手机号码"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil];
        [alert show];
        //获得焦点
        [txtMobilePhone becomeFirstResponder];
    }
    else if(getMobilePhone.length!=11){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"手机号码不正确"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil];
        [alert show];
        //获得焦点
        [txtMobilePhone becomeFirstResponder];
    }
    else{
        
        btnMobileCode.enabled = FALSE;
        
        [sender resignFirstResponder];
        
        timerSeconds = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        
        
        
        [self getMobileCode];
        
    }
}

- (void)timeFireMethod{
    
    secondsNum--;
    [btnMobileCode setTitle:[NSString stringWithFormat:@"%d秒",secondsNum] forState:UIControlStateNormal];
    
    if(secondsNum==0){
        btnMobileCode.enabled = TRUE;
        [btnMobileCode setTitle:@"获取" forState:UIControlStateNormal];
        [timerSeconds invalidate];
        secondsNum = 60;
    }
}

//获取验证码
- (void)getMobileCode
{
    @try {
        
        NSString *getMobilePhone = txtMobilePhone.text;
        getMobilePhone = [getMobilePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        int randomNum = (arc4random() % 10000) + 99999;
        getValidateCode = [NSString stringWithFormat:@"%d",randomNum];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:getValidateCode forKey:@"cloudin_PAXY365Parent_mobile_code"];
        NSLog(@"code=%@",getValidateCode);
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&mobile=%@&code=%d&type=code",ValidateVode,getMobilePhone,randomNum];
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            
            NSLog(@"Status=%@",getStatus);
            if ([getStatus isEqualToString:@"1"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"验证码已发送至你的手机，请注意查收"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:nil];
                [alert show];
                [txtCode becomeFirstResponder];
                
                 btnPost.enabled = TRUE;
                flagMobile = 1;
            }
            else if ([getStatus isEqualToString:@"2"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"手机号码不存在"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:nil];
                [alert show];
                [txtMobilePhone resignFirstResponder];
                flagMobile = 2;
                btnMobileCode.enabled = TRUE;
                [btnMobileCode setTitle:@"获取" forState:UIControlStateNormal];
                [timerSeconds invalidate];
                secondsNum = 60;
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"验证码发送失败"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
