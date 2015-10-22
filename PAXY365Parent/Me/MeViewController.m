//
//  MeViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MeViewController.h"

#import "UploadImageViewController.h"
#import "LoginViewController.h"
#import "UpdateUserPasswordViewController.h"
#import "UpdateUserDetailsViewController.h"
#import "MyWarningViewController.h"
#import "ChildViewController.h"
#import "BindListViewController.h"

#import "MyFavoriteViewController.h"
#import "SettingViewController.h"
#import "AppDelegate.h"

#import "Common.h"
#import "Reachability.h"
#import "Config.h"
#import "DataSource.h"
#import "EGOImageView.h"
#import "InternationalControl.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MeViewController ()

@end

@implementation MeViewController
@synthesize scrollView;
@synthesize lblCity;
@synthesize btnShowMessageCount;
@synthesize userImage;
@synthesize langTxtMyAddress;
@synthesize langTxtMyComment;
@synthesize langTxtMyFavorite;
@synthesize langTxtMyInfo;
@synthesize langTxtMyInvoice;
@synthesize langTxtPassword;
@synthesize btnExist;
@synthesize lblChild;

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
        scrollView.contentSize = CGSizeMake(320,650);
    }

    
    //检测是否登录
    NSString *getUserName = nil;
    NSString *getUserType = nil;
    NSString *getSelectedCity = nil;
    NSString *getLocationCity = nil;
    NSString *flagShowMessage = nil;
    NSString *getChildName = nil;
    NSString *getClassName = nil;
    NSString *getGradeID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        getUserName = [standardUserDefaults objectForKey:@"cloudin_365paxy_nickname"];
        getUserType = [standardUserDefaults objectForKey:@"cloudin_365paxy_usertype"];
        getSelectedCity = [standardUserDefaults objectForKey:@"cloudin_365paxy_selectedcity"];
        getLocationCity = [standardUserDefaults objectForKey:@"cloudin_365paxy_location_city"];
        flagShowMessage = [standardUserDefaults objectForKey:@"cloudin_365paxy_message_me"];
        getChildName = [standardUserDefaults objectForKey:@"cloudin_365paxy_childname"];
        getClassName = [standardUserDefaults objectForKey:@"cloudin_365paxy_default_classname"];
        getGradeID = [standardUserDefaults objectForKey:@"cloudin_365paxy_default_gradeid"];

        if (getSelectedCity == nil) {
            if (getLocationCity == nil) {
                getLocationCity = DefaultCity;
            }
            getSelectedCity = getLocationCity;
        }

        lblCity.text = getSelectedCity;
        

        if (getClassName.length==0 || [getClassName isEqualToString:@"-1"]) {
            lblChild.text = @"未绑定";
        }
        else{
            lblChild.text = [NSString stringWithFormat:@"%@(%@)班",getClassName,getGradeID];
        }

        
        [btnExist setTitle:[NSString stringWithFormat:@"退出登录(%@)",getUserName] forState:UIControlStateNormal];
    }
    
    [self checkNetwork];
    
    //接收用户操作返回结果消息
    if ([flagShowMessage isEqualToString:@"1"]) {
        
        [self showPopMessage:@"密码修改成功"];
        
        //退出当前用户
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"cloudin_365paxy_username"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_login_flag"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_uid"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_shopid"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_username"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_nickname"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_selected_address_intro"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_selected_address_name"];
        [defaults setObject:nil forKey:@"cloudin_365paxy_selected_invoice_title"];
        
        btnExist.hidden = TRUE;

        
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
        
    }
    if ([flagShowMessage isEqualToString:@"2"]) {
        
        [self showPopMessage:@"更新成功"];
    }
    if ([flagShowMessage isEqualToString:@"3"]) {
        
        [self showPopMessage:@"更新成功"];
    }
    if ([flagShowMessage isEqualToString:@"4"]) {
        
        [self showPopMessage:@"绑定成功"];
    }
    
    //加载头像
    NSString *getHeadImage = [standardUserDefaults objectForKey:@"cloudin_365paxy_headimage"];
    NSString *getHeadImageURL = getHeadImage;
    [self.userImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                       placeholderImage:[UIImage imageNamed:@"default_image_head.png"] options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   //加载图片及指示器效果
                                   if (!headActivityIndicator) {
                                       [userImage addSubview:headActivityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                       headActivityIndicator.center = userImage.center;
                                       [headActivityIndicator startAnimating];
                                   }
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   //清除指示器效果
                                   [headActivityIndicator removeFromSuperview];
                                   headActivityIndicator = nil;
                               }];
    
    //圆角效果
    //self.headImageView.image = [self ellipseImage:headImageView.image withInset:5];
    
    //UIButton *btnHeadImage = [[UIButton alloc] initWithFrame: CGRectMake(99, 12, 100, 100)];
    //[btnHeadImage addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
    //[btnHeadImage setBackgroundColor:[UIColor clearColor]];
    //[self.scrollView addSubview:btnHeadImage];

}

//显示弹出消息
-(void)showPopMessage:(NSString *)message
{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_me"];
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
        
        // 弹出对话框提醒用户
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络连接失败！";
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
    
    self.view.backgroundColor = SubBgColor;
 
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"用户中心";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    

    //返回
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    //设置
    UIImage *saveImage = [UIImage imageNamed: @"icon_settings.png"];
    UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
    UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    //[saveUIButton setTitle:langTxtRefresh forState:UIControlStateNormal];
    [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    saveUIButton.frame = CGRectMake(0, 0, saveImage.size.width, saveImage.size.height);
    [saveUIButton addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
    [containingSaveView addSubview:saveUIButton];
    UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
    self.navigationItem.rightBarButtonItem = containingSaveButton;

}

//返回页面
- (void)backView
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
}

- (void)gotoSetting
{
    SettingViewController *nextController = [SettingViewController alloc];
    nextController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextController animated:YES];
}

//上传图片
-(void) uploadHeadImage
{
    NSLog(@"上传图片");
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        //已登陆
        UploadImageViewController *nextController = [[UploadImageViewController alloc] init];
        nextController.setFlag = @"1";
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }

}


//修改信息
- (IBAction) btnUpdateUserInfoPressed: (id) sender
{
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        //已登陆
        UpdateUserDetailsViewController *nextController = [[UpdateUserDetailsViewController alloc] init];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
}

//更新孩子关系
- (IBAction) btnUpdateChildPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"2" forKey:@"cloudin_365paxy_bind_back_flag"];
    
    BindListViewController *nextController = [BindListViewController alloc];
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextController animated:YES];
}

//修改密码
- (IBAction) btnUpdatePasswordPressed: (id) sender
{
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        //已登陆
    UpdateUserPasswordViewController *nextController = [[UpdateUserPasswordViewController alloc] init];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
    }
}


//我收藏的
- (IBAction) btnMyFavoritePressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"50" forKey:@"cloudin_365paxy_nodata_flag"];
    
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        //已登陆
        
        MyFavoriteViewController *nextController = [MyFavoriteViewController alloc];
        nextController.setTitle = @"我收藏的";
        nextController.setFlag = @"1";
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
}

//我分享的
- (IBAction) btnMySharePressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"50" forKey:@"cloudin_365paxy_nodata_flag"];
    
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        //已登陆
        
        MyFavoriteViewController *nextController = [MyFavoriteViewController alloc];
        nextController.setTitle = @"我分享的";
        nextController.setFlag = @"2";
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }

}


//我的警示台
- (IBAction) btnMyWarningPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"50" forKey:@"cloudin_365paxy_nodata_flag"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_warning"];
    
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        //已登陆
        [defaults setObject:getUserID forKey:@"cloudin_365paxy_warning_userid"];
        [defaults setObject:@"2" forKey:@"cloudin_365paxy_warning_status"];
        
        MyWarningViewController *nextController = [MyWarningViewController alloc];
        nextController.setTitle = @"我的警示台";
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
    
}

//不要边框，只把图片变成圆形
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset
{
    return [self ellipseImage:image withInset:inset withBorderWidth:0 withBorderColor:[UIColor clearColor]];
}

- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f , image.size.height - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width);
        CGContextAddEllipseInRect(context, CGRectMake(inset + width/2, inset +  width/2, image.size.width - width- inset * 2.0f, image.size.height - width - inset * 2.0f));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


- (IBAction) btnLogoutPressed: (id) sender
{
    [self logout];
}

- (void)logout
{
    //退出当前用户
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_username"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_login_flag"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_uid"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_shopid"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_username"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_nickname"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selected_address_intro"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selected_address_name"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selected_invoice_title"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_head_image"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_exit"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_edit_studentno"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_1"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_2"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_3"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_4"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_5"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_6"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_7"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_8"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_9"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_10"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_upload_img_10"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_childname"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_default_classname"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_default_gradeid"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_head_image"];
    
    
    //退出环信
    __weak MeViewController *weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"setting.logoutOngoing", @"loging out...")];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        [weakSelf hideHud];
        if (error && error.errorCode != EMErrorServerNotLogin) {
            [weakSelf showHint:error.description];
        }
        else{
            [[ApplyViewController shareController] clear];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        }
    } onQueue:nil];
    
    btnExist.hidden = TRUE;
    
    [self backView];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
