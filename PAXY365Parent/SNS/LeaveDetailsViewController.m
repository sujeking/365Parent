//
//  LeaveDetailsViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/21.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "LeaveDetailsViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "EaseMob.h"

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface LeaveDetailsViewController ()

@end

@implementation LeaveDetailsViewController
@synthesize messageEntity;
@synthesize headImage;
@synthesize imageView;
@synthesize lblName;
@synthesize lblDate;
@synthesize lblDays;
@synthesize lblDesc;
@synthesize lblReviewName;
@synthesize lblStatus;
@synthesize scrollView;
@synthesize btnReviewNO;
@synthesize btnReviewOK;
@synthesize txtResult;
@synthesize lblLeaveTime;
@synthesize lblLeaveType;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,700);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,700 + 100);
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
    titleLabel.text = @"详情";
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
    
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        if ([getUserID isEqualToString:messageEntity.SendUserID]) {
            
            //显示删除按钮
            UIImage *saveImage = [UIImage imageNamed: @"btn_box_bg.png"];
            UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
            UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
            [saveUIButton setTitle:@"删除" forState:UIControlStateNormal];
            [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            saveUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            saveUIButton.frame = CGRectMake(0, 0, 60, saveImage.size.height);
            [saveUIButton addTarget:self action:@selector(delData) forControlEvents:UIControlEventTouchUpInside];
            [containingSaveView addSubview:saveUIButton];
            UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
            self.navigationItem.rightBarButtonItem = containingSaveButton;
        }
    }
    
    scrollView.delegate = self;
    
    
    //头像
    NSString *getHeadImage = messageEntity.SendUserImage;
    if ([getHeadImage rangeOfString:@".png"].location !=NSNotFound) {
        getHeadImage = [getHeadImage stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
    }
    else if ([getHeadImage rangeOfString:@".jpg"].location !=NSNotFound) {
        getHeadImage = [getHeadImage stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
    }

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
    
    
    NSString *getMessageImage = messageEntity.MessageImage;
    if ([getMessageImage rangeOfString:@".png"].location !=NSNotFound) {
        getMessageImage = [getMessageImage stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([getMessageImage rangeOfString:@".jpg"].location !=NSNotFound && [getMessageImage rangeOfString:@"_m.jpg"].location ==NSNotFound) {
        getMessageImage = [getMessageImage stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:getMessageImage forKey:@"cloudin_365paxy_show_image_leave"];
    
    [self.imageView setImageWithURL:[NSURL URLWithString:getMessageImage]
                   placeholderImage:[UIImage imageNamed:@"default_image_320_150.png"] options:SDWebImageProgressiveDownload
                           progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                               //加载图片及指示器效果
                               if (!activityIndicator) {
                                   [imageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                   activityIndicator.center = imageView.center;
                                   [activityIndicator startAnimating];
                               }
                           } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                               //清除指示器效果
                               [activityIndicator removeFromSuperview];
                               activityIndicator = nil;
                           }];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
    
    
    lblName.text = messageEntity.SendUserName;
    lblName.textColor = TxtLightBlack;
    
    NSString *getDate = messageEntity.AddDate;
    if ([getDate isEqualToString:@"1"]) {
        getDate = messageEntity.ShowDate;
        
    }
    else{
        getDate = messageEntity.AddDate;
    }
    
    lblDate.text = getDate;
    lblDate.textColor = TxtGray;
    
    lblReviewName.text = messageEntity.AcceptUserName;
    lblReviewName.textColor = TxtGray;
    
    lblStatus.text = messageEntity.MessageStatus;
    lblStatus.textColor = TxtGray;
    
    lblDays.text = [NSString stringWithFormat:@"%@",messageEntity.LeaveDays];
    lblDays.textColor = TxtGray;
    
    lblLeaveType.text = messageEntity.LeaveType;
    lblLeaveType.textColor = TxtGray;
    
    lblLeaveTime.text = messageEntity.LeaveTime;
    lblLeaveTime.textColor = TxtGray;

    lblDesc.text = messageEntity.MessageContent;
    
    NSString *getReviewDesc = messageEntity.ReviewDesc;
    txtResult.text = getReviewDesc;
    txtResult.textColor = TxtBlue;
    txtResult.backgroundColor = TxtLightGray2;
    if (getReviewDesc.length==0) {
        txtResult.hidden = TRUE;
    }
    else{
        txtResult.hidden = FALSE;
    }
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



//按完Done键以后关闭键盘
- (IBAction) txtResultEditing:(id)sender
{
    [txtResult resignFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtResult resignFirstResponder];
}

//添加好友
- (IBAction) btnReviewOKPressed: (id) sender
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        [self reviewStatus:@"2"];
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
        
        [self reviewStatus:@"3"];
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



//审批状态
- (void)reviewStatus:(NSString *)status
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *getDesc = txtResult.text;
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&mid=%@&status=%@&desc=%@",AddReviewUrl,messageEntity.MessageID,status,getDesc];
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
            NSLog(@"Reivew Status=%@",getStatus);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"2" forKey:@"cloudin_365paxy_message_leave"];
            
            [self closeView];
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}


//删除
- (void)delData
{
    @try {
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&mid=%@",MessageDelUrl,messageEntity.MessageID];
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
            
            NSLog(@"Visit Status=%@",getStatus);
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"3" forKey:@"cloudin_365paxy_message_leave"];
            
            [self closeView];
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}

//点击查看图片
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    //接收用户操作返回结果消息
    NSString *showImageURL = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        showImageURL = [defaults objectForKey:@"cloudin_365paxy_show_image_leave"];
    }
    
    NSInteger count = 1;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    
    MJPhoto *photo = [[MJPhoto alloc] init];
    // 替换为中等尺寸图片
    if ([showImageURL rangeOfString:@".png"].location !=NSNotFound) {
        showImageURL = [showImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_b.jpg"];
    }
    else if ([showImageURL rangeOfString:@".jpg"].location !=NSNotFound && [showImageURL rangeOfString:@"_b.jpg"].location !=NSNotFound) {
        showImageURL = [showImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_b.jpg"];
    }
    photo.url = [NSURL URLWithString:showImageURL]; // 图片路径
    //photo.srcImageView = self.scrollView.subviews[i]; // 来源于哪个UIImageView
    [photos addObject:photo];
    
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
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
