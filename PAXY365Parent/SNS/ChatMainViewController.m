//
//  ChatMainViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/23.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ChatMainViewController.h"

#import "ChatUsersViewController.h"
#import "FriendsListViewController.h"
#import "FriendsTipViewController.h"
#import "UpdateUserDetailsViewController.h"


#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"
#import "GRAlertView.h"

@interface ChatMainViewController ()

@end

@implementation ChatMainViewController
@synthesize lblClassName;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"通讯录";
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
    
    //新增
    UIImage *saveImage = [UIImage imageNamed: @"icon_user_add.png"];
    UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
    UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    //[saveUIButton setTitle:langTxtRefresh forState:UIControlStateNormal];
    [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    saveUIButton.frame = CGRectMake(0, 0, saveImage.size.width, saveImage.size.height);
    [saveUIButton addTarget:self action:@selector(gotoAdd) forControlEvents:UIControlEventTouchUpInside];
    [containingSaveView addSubview:saveUIButton];
    UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
    self.navigationItem.rightBarButtonItem = containingSaveButton;
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,40)];
    searchBar.placeholder = @"搜索好友";
    //[searchBar sizeToFit];
    searchBar.backgroundImage = [UIImage imageNamed:@"search_bg.png"];
    searchBar.delegate = self;
    //[searchBar becomeFirstResponder];
    [self.view addSubview:searchBar];
    [searchBar release];
    
    self.view.backgroundColor = TxtBlue;
    
    NSString *getClassName = nil;
    NSString *getGradeName = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        //设置我的班级名称
        getClassName = [standardUserDefaults objectForKey:@"cloudin_365paxy_classname"];
        getGradeName = [standardUserDefaults objectForKey:@"cloudin_365paxy_gradename"];
        if (getClassName.length==0) {
            lblClassName.text = @"我的班级";
            
            [self showDialogMessage:@"你还没有设置学校/年级/班级信息，请先到个人中心设置"];
            
            
        }
        else{
            lblClassName.text = [NSString stringWithFormat:@"%@%@",getClassName,getGradeName];
        }
    }
    
    
}

//关闭页面
- (void)closeView
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

- (void)gotoAdd
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_keywords_friends"];
    
    FriendsListViewController *vc = [FriendsListViewController alloc];
    vc.setTitle = @"我的好友";
    vc.setFlag = @"2";
    [vc sendGetDatas];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction) btnNewUsersPressed: (id) sender
{
    FriendsTipViewController *vc = [FriendsTipViewController alloc];
    vc.setTitle = @"新的好友";
    vc.setFlag = @"1";
    [vc sendGetDatas];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction) btnChatGroupPressed: (id) sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                    message:@"环信服务器连接失败！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction) btnContactsPressed: (id) sender
{
    ChatUsersViewController *vc = [ChatUsersViewController alloc];
    vc.setTitle = @"通讯录";
    vc.setFlag = @"1";
    [vc sendGetDatas];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Searching

- (void)updateSearchString:(NSString*)searchString
{
    //[searchString release];
    searchString = [[NSString alloc]initWithString:searchString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:searchString forKey:@"cloudin_365paxy_keywords_friends"];
    
    FriendsListViewController *vc = [FriendsListViewController alloc];
    vc.setTitle = @"我的好友";
    vc.setFlag = @"2";
    [vc sendGetDatas];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.text= @"";
    [self updateSearchString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self updateSearchString:searchBar.text];
    [searchBar resignFirstResponder];   //隐藏输入键盘
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
        UpdateUserDetailsViewController *nextController = [UpdateUserDetailsViewController alloc];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
        
    }
    else{
        //取消
        [self closeView];
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
