//
//  TabsViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "TabsViewController.h"

#import "SNSViewController.h"
#import "SuperParentViewController.h"
#import "QuestionListViewController.h"
#import "OnlineViewController.h"

#import "Common.h"
#import "Config.h"

@interface TabsViewController ()

@end

@implementation TabsViewController
@synthesize setIndex;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

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
    

    self.view.backgroundColor = MainBgColor;

    /*
    //信息中心
    InfoListViewController *view1Controller = [[InfoListViewController alloc]init];
    //[view1Controller initWithStyle: UITableViewStyleGrouped];
    [view1Controller setTitle:@"信息中心"];
    [view1Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu1_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu1.png"]];
    [view1Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [view1Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:view1Controller];
    
    //365在线
    OnlineViewController *view2Controller = [[OnlineViewController alloc] init];
    [view2Controller setTitle:@"365在线"];
    //[view2Controller sendGetDatas];
    [view2Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu2_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu2.png"]];
    [view2Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [view2Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:view2Controller];
    
    //家校互动
    SNSViewController *view3Controller = [[SNSViewController alloc] init];
    [view3Controller setTitle:@"家校互动"];
    //[view3Controller sendGetDatas];
    [view3Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu3_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu3.png"]];
    [view3Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [view3Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:view3Controller];
    
    //超级家长
    SuperParentViewController *view4Controller = [[SuperParentViewController alloc] init];
    [view4Controller setTitle:@"超级家长"];
    [view4Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu4_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu4.png"]];
    [view4Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [view4Controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:view4Controller];
    
    
    tabBarViewController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];
    tabBarViewController.selectedIndex = 2;
    //设置tabbar背景
    //[tabBarViewController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
     */
    
}

//返回页面
- (void)backView
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"cloudin_365paxy_click_type"];

    
    if(item.tag == 1){
        
        [self setTitle:@"信息中心"];
        
    }else if(item.tag == 2){
        
        [self setTitle:@"365在线"];
        
    }else if(item.tag == 3){
        
        [self setTitle:@"家校互动"];
        
    } else if(item.tag == 4){
        
        [self setTitle:@"意见反馈"];
        
    }
    
    self.navigationController.navigationBar.translucent = FALSE;
    
}

- (void)setTitle:(NSString *)title{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
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
