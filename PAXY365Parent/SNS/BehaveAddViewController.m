//
//  BehaveAddViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BehaveAddViewController.h"

#import "UploadImageViewController.h"
#import "ContactsListViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>



@interface BehaveAddViewController ()

@end

@implementation BehaveAddViewController
@synthesize txtContent;
@synthesize btnSelectContacts;
@synthesize imageView8;
@synthesize scrollView;
@synthesize activityIndicator;
@synthesize btnPost;
@synthesize lblPlaceholder;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 100);
    }
    
    
    NSString *getTempSelectCourseName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getTempSelectCourseName = [defaults objectForKey:@"cloudin_365paxy_selectedtemp_contactsname"];
        if (getTempSelectCourseName.length>0) {
            [btnSelectContacts setTitle:getTempSelectCourseName forState:UIControlStateNormal];
        }
    }
    
    
    //加载图片cloudin_eatla_upload_img_8
    [self performSelectorOnMainThread:@selector(loadNewImg) withObject:nil waitUntilDone:NO];//主线程
}

- (void)loadNewImg
{
    NSString *getImg8URL = nil;
    NSString *getUploadImg8= nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        
        //image-8
        getImg8URL = [defaults objectForKey:@"cloudin_365paxy_upload_img_8"];
        getUploadImg8 = [defaults objectForKey:@"cloudin_365paxy_message_upload8"];
        //当NSString值为Int时，必须强制转换为NSString，否则在引用时会引起"[__NSCFNumber length]: unrecognized selector sent to instance"
        getUploadImg8 = [NSString stringWithFormat:@"%@",getUploadImg8];
        
        //接收用户操作返回结果消息
        if ([getUploadImg8 isEqualToString:@"1"]) {
            
            [self showMessage:@"上传成功"];
        }
        
        //显示图片
        if (getImg8URL != nil) {
            
            NSString *getHeadImageURL = [NSString stringWithFormat:@"http://img.365paxy.org.cn%@",getImg8URL];
            if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
            }
            else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
            }
            [self.imageView8 setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                            placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        //加载图片及指示器效果
                                        if (!activityIndicator) {
                                            [imageView8 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                            activityIndicator.center = imageView8.center;
                                            [activityIndicator startAnimating];
                                        }
                                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                        //清除指示器效果
                                        [activityIndicator removeFromSuperview];
                                        activityIndicator = nil;
                                    }];
        }
        
        
    }
    
}


//显示弹出消息
-(void)showMessage:(NSString *)message
{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload8"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"发布在校表现";
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
    
    imageView8.contentMode = UIViewContentModeScaleAspectFit;
    
    txtContent.layer.borderColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:206/255.0 alpha:1.0].CGColor;
    txtContent.layer.borderWidth = 0.5;
    txtContent.layer.cornerRadius = 5.0;
    //[txtContent becomeFirstResponder];
    
    txtContent.delegate = self;
    txtContent.returnKeyType = UIReturnKeyDone;
    
    scrollView.delegate = self;
    
}


//关闭页面
- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

//选择通讯录
- (IBAction) btnSelectContactsPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_contacts"];
    
    ContactsListViewController *nextController = [ContactsListViewController alloc];
    nextController.setFlag = @"1";
    nextController.setKeywords = @"-1";
    nextController.setTitle = @"选择通讯录";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}


//按完Done键以后关闭键盘
- (IBAction) txtTitleCodeEditing:(id)sender
{
    [txtContent becomeFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtContent resignFirstResponder];
}

- (IBAction) btnUpload8Pressed: (id) sender
{
    UploadImageViewController *nextController = [[UploadImageViewController alloc] init];
    nextController.setFlag = @"8";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
    [self presentViewController:navigationController animated:YES completion:^{
        //
    }];
    [nextController release];
    [navigationController release];
    
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
        [txtContent resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction) btnPostPressed: (id) sender
{
    [self checkData];
}

//检测数据
- (void)checkData
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getTitle = txtContent.text;
        
        if (getTitle.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入在校表现！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(getTitle.length>500){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"在校表现内容不能超过500个汉字！"
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
    NSString *getDesc = txtContent.text;
    
    @try {
        
        NSString *getUserID = nil;
        NSString *getContactsID = nil;
        NSString *getImage8 = nil;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
            getContactsID = [defaults objectForKey:@"cloudin_365paxy_selected_contactsid"];
            getImage8 = [defaults objectForKey:@"cloudin_365paxy_upload_img_8"];
        }
        
        if (getImage8==nil) {
            getImage8 = @"none";
        }
        
        //ChannelID:1=家庭作业，2=成绩分析，3=在校表现，4=网上家访，5=请假条
        NSString *getAcceptUserID = getContactsID;
        

        //提交
        NSString *urlString = [NSString stringWithFormat:@"%@?day=0&senduid=%@&acceptuid=%@&type=0&title=-1&content=%@&flag=1&courseid=-1&channelid=3&image=%@",MessageAddUrl,getUserID,getAcceptUserID,getDesc,getImage8];
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
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_behave"];
                
                [self closeView];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"发布失败！"
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
