//
//  FriendsReviewViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/23.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "FriendsReviewViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "EaseMob.h"


@interface FriendsReviewViewController ()

@end

@implementation FriendsReviewViewController
@synthesize contactsEntity;
@synthesize headImage;
@synthesize lblName;
@synthesize lblDate;
@synthesize scrollView;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 100);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = contactsEntity.NickName;
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
    
    scrollView.delegate = self;
    
    
    //头像
    NSString *getHeadImage = contactsEntity.UserImage;
    [self.headImage setImageWithURL:[NSURL URLWithString:getHeadImage]
                   placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                           progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                               //加载图片及指示器效果
                               if (!activityIndicator) {
                                   [headImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                   activityIndicator.center = headImage.center;
                                   [activityIndicator startAnimating];
                               }
                           } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                               //清除指示器效果
                               [activityIndicator removeFromSuperview];
                               activityIndicator = nil;
                           }];
    
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 5.0;
    
    lblName.text = contactsEntity.NickName;
    lblName.textColor = TxtLightBlack;
    
    lblDate.text = [NSString stringWithFormat:@"加入时间：%@", contactsEntity.AddDate];
    lblDate.textColor = TxtGray;
    
}

//关闭页面
- (void)closeView
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

//拨打电话
- (IBAction) btnPhonePressed: (id) sender
{
    NSString *number = contactsEntity.UserPhone;
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

//发短信
- (IBAction) btnSMSPressed: (id) sender
{
    NSString *number = contactsEntity.UserPhone;
    
    NSString *num = [[NSString alloc] initWithFormat:@"sms://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

//添加好友
- (IBAction) btnReviewYESPressed: (id) sender
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        [self reviewFriends:@"2"];
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

- (IBAction) btnReviewNOPressed: (id) sender
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        [self reviewFriends:@"3"];
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

//审批好友
- (void)reviewFriends:(NSString *)status
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&adduid=%@&status=%@",ReviewFriendUrl,getUserID,contactsEntity.UserID,status];
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
            NSLog(@"status：%@",getStatus);
            
            if ([status isEqualToString:@"3"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"2" forKey:@"cloudin_365paxy_message_reviewfriends"];
            }
            else{
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_reviewfriends"];
            }

            [self closeView];
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
