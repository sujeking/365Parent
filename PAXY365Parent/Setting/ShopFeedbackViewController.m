//
//  ShopFeedbackViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ShopFeedbackViewController.h"

#import "InternationalControl.h"
#import "Common.h"
#import "Config.h"
#import "DataSource.h"

@interface ShopFeedbackViewController ()

@end

@implementation ShopFeedbackViewController
@synthesize lblContent;
@synthesize scrollView;
@synthesize btnPost;
@synthesize lblPlaceholder;
@synthesize setShopID;
@synthesize setShopName;

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
    
    [InternationalControl initUserLanguage];
    NSBundle *bundle = [InternationalControl bundle];
    //显示菜单文字
    NSString *getTitle = [bundle localizedStringForKey:@"FEEDBACK_TITLE" value:nil table:@"InfoPlist"];

    
    NSString *txtOK = [bundle localizedStringForKey:@"SUBMIT" value:nil table:@"InfoPlist"];
    [btnPost setTitle:txtOK forState:UIControlStateNormal];
    
    langTxtYourSuggestion =[bundle localizedStringForKey:@"FEEDBACK_CHECK" value:nil table:@"InfoPlist"];
    langTxtSuccess =[bundle localizedStringForKey:@"FEEDBACK_SHOP_SUCCESS" value:nil table:@"InfoPlist"];
    
    langTxtAlertWarning = [bundle localizedStringForKey:@"ALERT_WARNING" value:nil table:@"InfoPlist"];
    langTxtAlertOK = [bundle localizedStringForKey:@"ALERT_OK" value:nil table:@"InfoPlist"];
    langTxtAlertFail = [bundle localizedStringForKey:@"ALERT_FAIL" value:nil table:@"InfoPlist"];
    langTxtNetwork = [bundle localizedStringForKey:@"NETWORK_FAIL" value:nil table:@"InfoPlist"];
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = getTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    lblContent.layer.borderColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:206/255.0 alpha:1.0].CGColor;
    lblContent.layer.borderWidth = 0.5;
    lblContent.layer.cornerRadius = 5.0;
    [lblContent becomeFirstResponder];
    
    lblContent.delegate = self;
    lblContent.returnKeyType = UIReturnKeyDone;
    
    
    scrollView.delegate = self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

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
 //   [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    //
    }];
}

- (IBAction) btnPostPressed: (id) sender
{
    NSString *getContent = lblContent.text;
    
    if ([getContent isEqualToString:@""] || getContent == NULL) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:langTxtAlertWarning
                                                        message:langTxtYourSuggestion
                                                       delegate:self
                                              cancelButtonTitle:langTxtAlertOK
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
  
        //设备信息
        NSString *systemVersion=[[UIDevice currentDevice] systemVersion];
        NSString *device=[[UIDevice currentDevice] model];
        NSString *version= [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        getContent = [NSString stringWithFormat:@"%@",getContent];
        
        NSString *getUserID = nil;
        NSString *getUserName = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
            getUserName = [standardUserDefaults objectForKey:@"cloudin_365paxy_username"];
        }
        
        NSString *getShopInfo = [NSString stringWithFormat:@"%@#%@#%@#%@",setShopName,setShopID,getUserName,getUserID];
        //flag=0用户,=1后台内测,=2商户
        NSString *urlString = [[NSString alloc] initWithFormat:@"%@?content=%@&email=%@&device=%@&os=%@&app=%@&flag=2",FeedbackUrl,getContent,getShopInfo,device,systemVersion,version];
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
                [defaults setObject:@"2" forKey:@"cloudin_365paxy_message_comments"];
                [self closeView];
                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:langTxtAlertWarning
                                                                message:langTxtAlertFail
                                                               delegate:self
                                                      cancelButtonTitle:langTxtAlertOK
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
