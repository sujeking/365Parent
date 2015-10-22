//
//  SNSViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee Lee on 15/6/1.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SNSViewController.h"

#import "NoticeListViewController.h"
#import "MailViewController.h"
#import "MailsViewController.h"
#import "ChatMainViewController.h"
#import "HXMainViewController.h"
#import "HXLoginViewController.h"
#import "ApplyViewController.h"
#import "ChatViewController.h"
#import "LoginViewController.h"
#import "BindListViewController.h"
#import "BindSelectViewController.h"

#import "Common.h"
#import "Reachability.h"
#import "Config.h"
#import "DataSource.h"
#import "GRAlertView.h"

@interface SNSViewController ()

@end

@implementation SNSViewController
@synthesize scrollView;
@synthesize btnMessageNum3;
@synthesize btnMessageNum2;
@synthesize btnMessageNum1;
@synthesize lblClassName;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,650);
    }
    
    NSString *getFlagMessage = nil;
    NSString *getClassName = nil;
    NSString *getGradeID = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getFlagMessage = [defaults objectForKey:@"cloudin_365paxy_message_changeclass"];
        getClassName = [defaults objectForKey:@"cloudin_365paxy_to_classname"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
        
        if ([getFlagMessage isEqualToString:@"1"]) {
            
            NSString *getTitle = [NSString stringWithFormat:@"当前切换到：%@(%@)班",getClassName,getGradeID];
            
            
            [self showMessage:getTitle];
        }
        
        if (getClassName!=nil) {
            lblClassName.text = [NSString stringWithFormat:@"班级信息(%@%@班)",getClassName,getGradeID];
        }
    
    }

}

//显示弹出消息
-(void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_changeclass"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置背景颜色
    self.scrollView.backgroundColor = SNSBgColor;
    
     _connectionState = eEMConnectionConnected;
    
    [self performSelectorOnMainThread:@selector(loadUsersNickandHead) withObject:nil waitUntilDone:NO];
    
    btnMessageNum1.hidden = TRUE;
    btnMessageNum2.hidden = TRUE;
    btnMessageNum3.hidden = TRUE;

}

//返回页面
- (IBAction) btnBackPressed: (id) sender
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
    
}

- (IBAction) btnChangePressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"cloudin_365paxy_goto_flag"];

    BindSelectViewController *vc = [BindSelectViewController alloc];
    vc.setTitle = @"切换班级";
    [vc sendGetDatas];
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//学校新闻公告
- (IBAction) btnMenus1Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"12" forKey:@"cloudin_365paxy_news_type"];
    [defaults setObject:@"2" forKey:@"cloudin_365paxy_news_flag"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_back_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"150" forKey:@"cloudin_365paxy_nodata_flag"];
    
    NoticeListViewController *nextController = [NoticeListViewController alloc];
    nextController.setTitle = @"校园信息";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
    
}

//即时沟通
- (IBAction) btnMenus2Pressed: (id) sender
{
    
    NSString *getClassName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getClassName = [defaults objectForKey:@"cloudin_365paxy_default_classname"];
        if (getClassName.length==0) {
            
            [self showDialogMessage:@"你还没有绑定班级，请先到个人中心设置"];
        }
        else{
            [self loginStateChange:nil];
        }
    }
}

//老师信箱
- (IBAction) btnMenus3Pressed: (id) sender
{
    NSString *getClassName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getClassName = [defaults objectForKey:@"cloudin_365paxy_default_classname"];
        if (getClassName.length==0) {
            
            [self showDialogMessage:@"你还没有绑定班级，请先到个人中心设置"];
        }
        else{
            
            [defaults setObject:@"0" forKey:@"cloudin_365paxy_goto_flag"];

            MailViewController *nextController = [MailViewController alloc];
            nextController.hidesBottomBarWhenPushed = YES;
            self.navigationController.navigationBarHidden = FALSE;
            [self.navigationController pushViewController:nextController animated:YES];
            [nextController release];
        }
    }
}


#pragma mark - private
//登陆状态改变
-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = nil;
    
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess) {//登陆成功加载主窗口控制器
        //加载申请通知的数据
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        
        /*
        HXMainViewController *nextController = [HXMainViewController alloc];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];*/
        
        HXMainViewController *nextController = [[HXMainViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
        
        
    }else{//登陆失败加载登陆页面控制器
        _hxMainController = nil;
        
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
        
    }
    
    //设置7.0以下的导航栏
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    
}

//加载用户昵称和头像
- (void)loadUsersNickandHead
{
    @try {
        
        NSString *getSchoolID = nil;
        NSString *getClassID = nil;
        NSString *getGradeID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults)
        {
            getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
            getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
            getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&sid=%@&cid=%@&gid=%@",UsersByClassListUrl,getSchoolID,getClassID,getGradeID];
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *dict = [[DataSource fetchJSON:urlString] retain];
        NSArray *array = [dict objectForKey:@"List"];
        NSLog(@"Count=%lu",(unsigned long)[array count]);
        for (int i = 0; i < [array count]; i ++) {
            
            NSDictionary *statusDict = [array objectAtIndex:i];
            NSString *getUserPhone = [statusDict objectForKey:@"UserPhone"];
            NSString *getNickName = [statusDict objectForKey:@"NickName"];
            NSString *getUserImage = [statusDict objectForKey:@"UserImage"];
            
            NSString *saveUserName = [NSString stringWithFormat:@"User%@",getUserPhone];
            NSString *saveNickHead = [NSString stringWithFormat:@"%@#%@",getNickName,getUserImage];
            
            NSString *saveNickName = [NSString stringWithFormat:@"Nick%@",getNickName];
            NSString *savePhoneHead = [NSString stringWithFormat:@"%@#%@",getUserPhone,getUserImage];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:saveNickHead forKey:saveUserName];
            [defaults setObject:savePhoneHead forKey:saveNickName];
            NSLog(@"%@:%@",getUserPhone,getNickName);

        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
}


//弹出消息对话框
- (void)showDialogMessage:(NSString *)message
{
    GRAlertView *alert;
    alert = [[GRAlertView alloc] initWithTitle:@"提醒"
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"确定", nil];
    
    [alert setTopColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           middleColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           bottomColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]             lineColor:[UIColor colorWithRed:153/255.0 green:206/255.0 blue:0/255.0 alpha:1.0]];
    
    
    [alert setFontName:@"Cochin-Bold"
             fontColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:226/255.0 alpha:1.0]
       fontShadowColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]];
    
    //[alert setImage:@"login_icon.png"];
    alert.animation = GRAlertAnimationNone;
    [alert show];
}

//处理弹出框动作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"Button pushed: %@, index %i", alertView.title, buttonIndex);
    if (buttonIndex == 1) {
        //
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"1" forKey:@"cloudin_365paxy_bind_back_flag"];
        
        BindListViewController *nextController = [BindListViewController alloc];
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
        
    }
    else{
        //取消
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popViewControllerAnimated:YES]; //back
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end