//
//  ServicePriceViewController.m
//  Car
//
//  Created by Cloudin's Adin on 14-8-27.
//  Copyright (c) 2014年 Shanghai Cloudin Network Technology Co.,Ltd. All rights reserved.
//

#import "ServicePriceViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"

@interface ServicePriceViewController ()

@end

@implementation ServicePriceViewController
@synthesize txtContent;
@synthesize btnPost;
@synthesize setServiceID;
@synthesize scrollView;

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
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"商家报价";
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
    
}

//关闭、返回页面
- (void)closeView
{
    [self dismissViewControllerAnimated:YES
     completion:^{
         //TODO
     }];
}

- (IBAction) btnAddPricePressed: (id) sender
{
    [self postData];
}

- (void)postData
{
    AHReach *reach = [AHReach reachForDefaultHost];
	if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getContent = txtContent.text;
        
        if(getContent.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入你的报价"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            [txtContent becomeFirstResponder];
        }
        else{
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(postServicePriceData) userInfo:nil repeats:NO];
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


- (void)postServicePriceData
{
    NSString *getPrice = txtContent.text;
    
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            getUserID = [standardUserDefaults objectForKey:@"cloudin_niceroad_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&sid=%@&price=%@",AddCommentUrl,getUserID,setServiceID,getPrice];
        NSLog(@"URL=%@",urlString);
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%d",[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            
            NSLog(@"Status=%@",getStatus);
            if ([getStatus isEqualToString:@"1"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"恭喜你，报价成功！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                
                txtContent.text = @"";
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"报价失败！"
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

//按完Done键以后关闭键盘
- (IBAction) txtContentEditing:(id)sender
{
    [txtContent resignFirstResponder];
    [self postData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
