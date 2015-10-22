//
//  LoginViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//
#import "LoginViewController.h"

#import "UserRegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "MeViewController.h"
#import "AppDelegate.h"

#import "DataSource.h"
#import "Config.h"
#import "Common.h"
#import "AHReach.h"
#import "Reachability.h"
#import "InternationalControl.h"
#import "Tool.h"

#import "EaseMob.h"
#import <CommonCrypto/CommonDigest.h>


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtUserName;
@synthesize txtPassword;
@synthesize btnLogin;
@synthesize btnForgetPassword;
@synthesize scrollView;
@synthesize langLblMoiblePhone;
@synthesize langLblPassword;
@synthesize langBtnRegister;

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
        
        scrollView.contentSize = CGSizeMake(320,700);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,700 + 100);
    }

    
    
    [self checkNetwork];
    
    //接收用户操作返回结果消息
    NSString *flagShowMessage = nil;
    NSString *getTempMobilePhone = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        flagShowMessage = [standardUserDefaults objectForKey:@"cloudin_365paxy_message_login"];
        getTempMobilePhone = [standardUserDefaults objectForKey:@"cloudin_365paxy_temp_mobilephone"];
        if (getTempMobilePhone!=nil) {
            
            
            txtUserName.text = getTempMobilePhone;
        }
    }
    
    if ([flagShowMessage isEqualToString:@"1"]) {
        
        [self showPopMessage:@"密码修改成功"];
    }
    if ([flagShowMessage isEqualToString:@"2"]) {
        
        [self showPopMessage:@"恭喜你，注册成功！"];
    }
    if ([flagShowMessage isEqualToString:@"3"]) {
        
        [self showPopMessage:@"恭喜你，注册成功！"];
    }
}


//显示弹出消息
-(void)showPopMessage:(NSString *)message
{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_login"];
}

-(void)checkNetwork
{
    Reachability *reach = [[Reachability reachabilityWithHostName:@"www.apple.com"] retain];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    if([reach isReachable])
    {
        NSLog(@"网络连接正常");
    }
    else
    {
        NSLog(@"网络连接不正常");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = langTxtNetwork;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    }
    
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    BOOL connectionRequired = [reach connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"网络不可用", @"请检查网络是否打开？");
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"2G/3G网络", @"");
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"WiFi网络", @"");
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@", @"网络连接状态");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    NSLog(@"%@",statusString);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor2;
    
    //获得焦点,iPhone4下会遮住，不大方便
    [txtUserName becomeFirstResponder];

    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"登录";
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

    //读取数据
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        NSString *getAutoLogin = [standardUserDefaults objectForKey:@"cloudin_365paxy_autologin"];
        //NSString *getSavePassword = [standardUserDefaults objectForKey:@"cloudin_365paxy_savepassword"];
        if ([getAutoLogin isEqualToString:@"YES"]) {
            txtUserName.text = [standardUserDefaults objectForKey:@"cloudin_365paxy_username"];
            txtPassword.text = [standardUserDefaults objectForKey:@"cloudin_365paxy_userpassword"];
        }
    }
    
    //一定要记得声明代理协议，否则不起作用
    scrollView.delegate = self;
    //txtUserName.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtUserName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtPassword];
}


//关闭或返回
- (void)closeView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"2" forKey:@"cloudin_365paxy_loginpop"];
    
    //self.navigationController.navigationBarHidden = TRUE;
    //[self.navigationController popViewControllerAnimated:YES]; //back
    
    [self dismissViewControllerAnimated:YES completion:^{
        //TODO
    }];
}

- (IBAction) btnLoginPressed: (id) sender
{
    btnLogin.enabled = FALSE;
    
    AHReach *reach = [AHReach reachForDefaultHost];
	if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getUserName = txtUserName.text;
        getUserName = [getUserName stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *getPassword = txtPassword.text;

        NSString *getFirstWord = nil;
        if (getUserName.length>1) {
            getFirstWord = [getUserName substringToIndex:1];
        }
        
        
        if (getUserName.length==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入手机号码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtUserName becomeFirstResponder];
            btnLogin.enabled = TRUE;
        }
        else if(getUserName.length!=11){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入正确的手机号码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtUserName becomeFirstResponder];
            btnLogin.enabled = TRUE;
        }
        else if(getPassword.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入密码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtPassword becomeFirstResponder];
            btnLogin.enabled = TRUE;
        }
        else{
            
            loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
            [loadingView starRun];
            [self.view addSubview:loadingView];
            
            [NSThread detachNewThreadSelector:@selector(postLoginData) toTarget:self withObject:nil];
            
            //[self postLoginData];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:langTxtNetwork
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        btnLogin.enabled = TRUE;
    }
}

//提交登陆
- (void)postLoginData
{
    NSString *getUserName = txtUserName.text;
    getUserName = [getUserName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *getPassword = txtPassword.text;
    
  
    @try {
     
        //绑定推送信息，当用户更换设备登陆时，需要绑定设备的推送参数
        //pushflag=1 iOS家长版，=2iOS教师版，=3安卓家长版，=4安卓教师版
        NSString *getPushAppID = nil;
        NSString *getPushUserID = nil;
        NSString *getPushChannelID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            getPushAppID = [standardUserDefaults objectForKey:@"cloudin_365paxy_push_appid"];
            getPushUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_push_userid"];
            getPushChannelID = [standardUserDefaults objectForKey:@"cloudin_365paxy_push_channelid"];
        }
        
        if (getPushAppID == nil) {
            getPushAppID = @"0";
        }
        if (getPushUserID == nil) {
            getPushUserID = @"0";
        }
        if (getPushChannelID == nil) {
            getPushChannelID = @"0";
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&password=%@&paid=%@&puid=%@&pcid=%@&flag=1&pushflag=1",LoginUrl,getUserName,getPassword,getPushAppID,getPushUserID,getPushChannelID];
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
            NSString *getUserID = [statusDict objectForKey:@"UserID"];
            NSString *getUserName = [statusDict objectForKey:@"UserName"];
            NSString *getNickName = [statusDict objectForKey:@"NickName"];
            NSString *getGender = [statusDict objectForKey:@"Gender"];
            NSString *getUserType = [statusDict objectForKey:@"UserType"];
            NSString *getSchoolID = [statusDict objectForKey:@"SchoolID"];
            NSString *getClassID = [statusDict objectForKey:@"ClassID"];
            NSString *getClassName = [statusDict objectForKey:@"ClassName"];
            NSString *getGradeName = [statusDict objectForKey:@"GradeName"];
            NSString *getGradeID = [statusDict objectForKey:@"GradeID"];
            NSString *getProvinceID = [statusDict objectForKey:@"ProvinceID"];
            NSString *getCityID= [statusDict objectForKey:@"CityID"];
            NSString *getDistrictID = [statusDict objectForKey:@"DistrictID"];
            NSString *getChildName= [statusDict objectForKey:@"ChildName"];
            NSString *getChildRelation = [statusDict objectForKey:@"ChildRelation"];
            NSString *getCourseName = [statusDict objectForKey:@"CourseID"];
            NSString *getTeacherType = [statusDict objectForKey:@"TeacherType"];
            NSString *getHeadImage = [statusDict objectForKey:@"HeadImage"];
            
            NSLog(@"Status=%@,ID=%@,Phone=%@",getStatus,getUserID,getUserName);
            //1=成功，2=密码错误，3=帐户不存在，4=未审核
            if ([getStatus isEqualToString:@"1"]) {
                
                NSLog(@"登陆成功！");
                
                getPassword =[self md5:getPassword];
                
                //保存
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:getUserID forKey:@"cloudin_365paxy_uid"];
                [defaults setObject:getUserName forKey:@"cloudin_365paxy_username"];
                [defaults setObject:getNickName forKey:@"cloudin_365paxy_nickname"];
                [defaults setObject:getGender forKey:@"cloudin_365paxy_gender"];
                [defaults setObject:getUserType forKey:@"cloudin_365paxy_usertype"];
                [defaults setObject:getSchoolID forKey:@"cloudin_365paxy_schoolid"];
                [defaults setObject:getClassID forKey:@"cloudin_365paxy_classid"];
                [defaults setObject:getClassName forKey:@"cloudin_365paxy_classname"];
                [defaults setObject:getGradeID forKey:@"cloudin_365paxy_gradeid"];
                [defaults setObject:getGradeName forKey:@"cloudin_365paxy_gradename"];
                [defaults setObject:getProvinceID forKey:@"cloudin_365paxy_provinceid"];
                [defaults setObject:getCityID forKey:@"cloudin_365paxy_cityid"];
                [defaults setObject:getDistrictID forKey:@"cloudin_365paxy_districtid"];
                [defaults setObject:getChildName forKey:@"cloudin_365paxy_childname"];
                [defaults setObject:getChildRelation forKey:@"cloudin_365paxy_childrelation"];
                [defaults setObject:getCourseName forKey:@"cloudin_365paxy_selected_coursename"];
                [defaults setObject:getTeacherType forKey:@"cloudin_365paxy_teacher_type"];
                [defaults setObject:getHeadImage forKey:@"cloudin_365paxy_head_image"];
                [defaults setObject:getClassName forKey:@"cloudin_365paxy_default_classname"];
                [defaults setObject:getClassName forKey:@"cloudin_365paxy_to_classname"];
                [defaults setObject:getGradeID forKey:@"cloudin_365paxy_default_gradeid"];
                
                /* 环信开始 */
                //异步登陆账号
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:getUserName
                                                                    password:getPassword
                                                                  completion:
                 ^(NSDictionary *loginInfo, EMError *error) {
                     [self hideHud];
                     if (loginInfo && !error) {
                         //设置是否自动登录
                         [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                         
                         // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
                         [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                         //获取数据库中数据
                         [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                         
                         //获取群组列表
                         [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
                         
                         //发送自动登陆状态通知
                         [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                         
                         NSLog(@"登录成功");
                     }
                     else
                     {
                         switch (error.errorCode)
                         {
                             case EMErrorNotFound:
                                 //TTAlertNoTitle(error.description);
                                 break;
                             case EMErrorNetworkNotConnected:
                                 //TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                                 break;
                             case EMErrorServerNotReachable:
                                 //TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                                 break;
                             case EMErrorServerAuthenticationFailure:
                                 //TTAlertNoTitle(error.description);
                                 break;
                             case EMErrorServerTimeout:
                                 //TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                                 break;
                             default:
                                 //TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                                 break;
                         }
                     }
                 } onQueue:nil];
                
                /* 环信结束 */
                
                
  
                [self closeView];
            }
            else if ([getStatus isEqualToString:@"2"]) {
                
                //获得焦点
                //[txtPassword becomeFirstResponder];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"密码错误"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
            }
            else if ([getStatus isEqualToString:@"3"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"手机号码不存在"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else {;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"登录失败"
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
    
    btnLogin.enabled = TRUE;
    [loadingView stopRun];
}

//按完Done键以后关闭键盘
- (IBAction) txtUserNameNextEditing:(id)sender
{
    //获得焦点
    [txtPassword becomeFirstResponder];
}

- (IBAction) txtPasswordDoneEditing:(id)sender
{
    [txtPassword resignFirstResponder];
}


//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtUserName resignFirstResponder];
    [txtPassword resignFirstResponder];
}


//忘记密码
- (IBAction) btnForgetPasswordPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_back_flag"];
    
    ForgetPasswordViewController *nextController = [ForgetPasswordViewController alloc];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
    [self presentViewController:navigationController animated:YES completion:^{
        //
    }];
    [nextController release];
    [navigationController release];
}

//跳转到注册页面
- (IBAction) btnRegisterPressed: (id) sender
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_back_flag"];
    
    UserRegisterViewController *nextController = [[UserRegisterViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
    [self presentViewController:navigationController animated:YES completion:^{
        //
    }];
    [nextController release];
    [navigationController release];
}

-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
   
    //限制手机号码最大11位
    if (self.txtUserName == textField)  //判断是否时我们想要限定的那个输入框
    {
        if (toBeString.length>10) {
            txtUserName.text = [toBeString substringWithRange:NSMakeRange(0, 11)];
        }

    }
    
    //密码最大20位
    if (self.txtPassword ==textField) {
        //
        if (toBeString.length>20) {
            txtPassword.text = [toBeString substringWithRange:NSMakeRange(0, 20)];
        }
    }

   
}


-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
