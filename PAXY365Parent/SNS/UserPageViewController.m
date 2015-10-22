//
//  UserPageViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/21.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "UserPageViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "EaseMob.h"
#import "ChatViewController.h"

#import "HXBaseTableViewCell.h"
#import "RealtimeSearchUtil.h"
#import "ChineseToPinyin.h"
#import "EMSearchBar.h"
#import "SRRefreshView.h"
#import "EMSearchDisplayController.h"
#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "GroupListViewController.h"
#import "ChatViewController.h"
#import "MyChatroomListViewController.h"
#import "ChatroomListViewController.h"
#import "RobotListViewController.h"
#import "ContactsViewController.h"

@interface UserPageViewController ()<IChatManagerDelegate>
{
    
}

@end

@implementation UserPageViewController
@synthesize contactsEntity;
@synthesize headImage;
@synthesize lblName;
@synthesize lblDate;
@synthesize scrollView;
@synthesize btnAddFriend;
@synthesize btnSendMessage;

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
    
    lblName.text = contactsEntity.NickName;
    lblName.textColor = TxtLightBlack;
    
    lblDate.text = [NSString stringWithFormat:@"加入时间：%@", contactsEntity.AddDate];
    lblDate.textColor = TxtGray;
    

    if ([self didBuddyExist:contactsEntity.UserPhone]) {
        //存在
        btnAddFriend.hidden = TRUE;
        btnSendMessage.hidden = FALSE;
    }
    else{
        //不存在
        btnAddFriend.hidden = FALSE;
        btnSendMessage.hidden = TRUE;
        
    }
    //[self checkFriends];
    
    //强制可以发消息
    //btnSendMessage.hidden = FALSE;
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
- (IBAction) btnAddFriendPressed: (id) sender
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){

        NSString *buddyName = contactsEntity.UserPhone;
        NSLog(@"Name:%@",buddyName);
        if ([self didBuddyExist:buddyName]) {
            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeat", @"'%@'has been your friend!"), buddyName];
            
            [EMAlertView showAlertWithTitle:message
                                    message:nil
                            completionBlock:nil
                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                          otherButtonTitles:nil];
            
        }
        else if([self hasSendBuddyRequest:buddyName])
        {
            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatApply", @"you have send fridend request to '%@'!"), buddyName];
            [EMAlertView showAlertWithTitle:message
                                    message:nil
                            completionBlock:nil
                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                          otherButtonTitles:nil];
            
        }else{
            [self showMessageAlertView];
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

- (IBAction) btnSendMessagePressed: (id) sender
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:contactsEntity.UserPhone isGroup:NO];
    chatVC.title = contactsEntity.NickName;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState == eEMBuddyFollowState_NotFollowed &&
            buddy.isPendingApproval) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed) {
            return YES;
        }
    }
    return NO;
}

- (void)showMessageAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:NSLocalizedString(@"saySomething", @"say somthing")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        //NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *username = contactsEntity.UserPhone;//[loginInfo objectForKey:kSDKUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"), username];
        }
        [self sendFriendApplyAtIndexPath:0
                                 message:messageStr];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    NSString *buddyName = contactsEntity.UserPhone;
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        if (error) {
            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
        }
        else{
            [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//添加好友
- (void)addFriends
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&adduid=%@",AddFriendUrl,getUserID,contactsEntity.UserID];
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
            if ([getStatus isEqualToString:@"1"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"发送邀请成功，等待对方确认！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                
                [btnAddFriend setTitle:@"等待确认" forState:UIControlStateNormal];
                btnAddFriend.enabled = FALSE;
            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}


- (void)checkFriends
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&touid=%@",CheckFriendUrl,getUserID,contactsEntity.UserID];
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
            if ([getStatus isEqualToString:@"1"]) {
                //不是好友
                btnSendMessage.hidden = TRUE;
                btnAddFriend.hidden = FALSE;
            }
            else if([getStatus isEqualToString:@"2"]){
                
                //等待确认
                [btnAddFriend setTitle:@"等待确认" forState:UIControlStateNormal];
                btnAddFriend.enabled = TRUE;
                btnSendMessage.hidden = FALSE;
            }
            else if([getStatus isEqualToString:@"3"]){
                
                //已是好友，发送消息
                btnSendMessage.hidden = FALSE;
                btnAddFriend.hidden = TRUE;
            }

            else{
                
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
